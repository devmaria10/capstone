/* global Vue, VueRouter, axios */

var HomePage = {
  template: "#home-page",
  data: function() {
    return {
      message: [],
      errors: [],
      email: "",
      password: ""
    };
  },
  created: function() {},
  methods: {},
  computed: {}
};

var SignupPage = {
  template: "#signup-page",
  data: function() {
    return {
      firstName: "",
      lastName: "",
      dob: "",
      streetAddress: "",
      city: "",
      state: "",
      zip: "",
      phoneNumber: "",
      email: "",
      password: "",
      passwordConfirmation: "",
      errors: []
    };
  },
  created: function() {
    console.log(this.firstName);
  },
  methods: {
    submit: function() {
      var params = {
        first_name: this.firstName,
        last_name: this.lastName,
        dob: this.dob,
        street_address: this.streetAddress,
        city: this.city,
        zip: this.zip,
        phone_number: this.phoneNumber,
        email: this.email,
        password: this.password,
        password_confirmation: this.passwordConfirmation
      };
      axios
        .post("/users", params)
        .then(function(response) {
          router.push("/login");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};

var LoginPage = {
  template: "#login-page",
  data: function() {
    return {
      email: "",
      password: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        auth: { email: this.email, password: this.password }
      };
      axios
        .post("/user_token", params)
        .then(function(response) {
          axios.defaults.headers.common["Authorization"] =
            "Bearer " + response.data.jwt;
          localStorage.setItem("jwt", response.data.jwt);
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = ["Invalid email or password."];
            this.email = "";
            this.password = "";
          }.bind(this)
        );
    }
  }
};

var ViewProfilePage = {
  template: "#view-profile-page",
  data: function() {
    return {
      // user: {
        id: "",
        first_name: "",
        last_name: "",
        dob: "",
        street_address: "",
        city: "",
        state: "",
        zip: "",
        phone_number: "",
        email: "",
        note: "",
        diagnosis: [{}],
        providers: [{}],
        user_medications: [{}],
        timers: [{}]    
      // }
    };
  },
  created: function() {
    axios.get("/view_profile" )
      .then(function(response) {
        console.log(response.data);
        // this.user = response.data;
        this.id = response.data.id;
        this.first_name = response.data.first_name;
        this.last_name = response.data.last_name;
        this.dob = response.data.dob;
        this.street_address = response.data.street_address;
        this.city = response.data.city;
        this.state = response.data.state;
        this.zip = response.data.zip;
        this.phone_number = response.data.phone_number;
        this.email = response.data.email;
        this.diagnosis = response.data.diagnosis;
        this.providers = response.data.providers;
        this.user_medications = response.data.user_medications;
        this.timers = response.data.timers;
      }.bind(this));
  },
  methods: {
    saveNote: function() {
      var params = {
        note: this.note,
        user_id: this.id
      };
      
      axios
        .post("/notes", params)
        .then(function(response) {
          router.push("/user");
        })
        .catch(
          function(error){
            this.errors = error.response.data.errors;
          }.bind(this));
    }
  },
  mounted: function() {
    $(document).ready(function() {
      

      try {
        var SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
        var recognition = new SpeechRecognition();
      }
      catch(e) {
        console.error(e);
        $('.no-browser-support').show();
        $('.app').hide();
      }


      var noteTextarea = $('#note-textarea');
      var noteContent = '';


      var instructions = $('#recording-instructions');
      var notesList = $('ul#notes');


      // Get all notes from previous sessions and display them.
      var notes = getAllNotes();
      renderNotes(notes);



      /*-----------------------------
            Voice Recognition 
      ------------------------------*/

      // If false, the recording will stop after a few seconds of silence.
      // When true, the silence period is longer (about 15 seconds),
      // allowing us to keep recording even when the user pauses. 
      recognition.continuous = true;

      // This block is called every time the Speech APi captures a line. 
      recognition.onresult = function(event) {

        // event is a SpeechRecognitionEvent object.
        // It holds all the lines we have captured so far. 
        // We only need the current one.
        var current = event.resultIndex;

        // Get a transcript of what was said.
        var transcript = event.results[current][0].transcript;

        // Add the current transcript to the contents of our Note.
        // There is a weird bug on mobile, where everything is repeated twice.
        // There is no official solution so far so we have to handle an edge case.
        var mobileRepeatBug = (current == 1 && transcript == event.results[0][0].transcript);

        if(!mobileRepeatBug) {
          noteContent += transcript;
          noteTextarea.val(noteContent);

          noteTextarea.get(0).dispatchEvent(new Event('input'));
        }
      };

      recognition.onstart = function() { 
        instructions.text('Voice recognition activated. Try speaking into the microphone.');
      }

      recognition.onspeechend = function() {
        instructions.text('You were quiet for a while so voice recognition turned itself off.');
      }

      recognition.onerror = function(event) {
        if(event.error == 'no-speech') {
          instructions.text('No speech was detected. Try again.');  
        };
      }



      /*-----------------------------
            App buttons and input 
      ------------------------------*/

      $('#start-record-btn').on('click', function(e) {
        if (noteContent.length) {
          noteContent += ' ';
        }
        recognition.start();
      });


      $('#pause-record-btn').on('click', function(e) {
        recognition.stop();
        instructions.text('Voice recognition paused.');
      });

      // Sync the text inside the text area with the noteContent variable.
      noteTextarea.on('input', function() {
        noteContent = $(this).val();
      })

      $('#save-note-btn').on('click', function(e) {
        recognition.stop();

        if(!noteContent.length) {
          instructions.text('Could not save empty note. Please add a message to your note.');
        }
        else {
          // Save note to localStorage.
          // The key is the dateTime with seconds, the value is the content of the note.
          saveNote(new Date().toLocaleString(), noteContent);

          // Reset variables and update UI.
          noteContent = '';
          renderNotes(getAllNotes());
          noteTextarea.val('burger');
          instructions.text('Note saved successfully.');
        }
            
      })


      notesList.on('click', function(e) {
        e.preventDefault();
        var target = $(e.target);

        // Listen to the selected note.
        if(target.hasClass('listen-note')) {
          var content = target.closest('.note').find('.content').text();
          readOutLoud(content);
        }

        // Delete note.
        if(target.hasClass('delete-note')) {
          var dateTime = target.siblings('.date').text();  
          deleteNote(dateTime);
          target.closest('.note').remove();
        }
      });



      /*-----------------------------
            Speech Synthesis 
      ------------------------------*/

      function readOutLoud(message) {
        var speech = new SpeechSynthesisUtterance();

        // Set the text and voice attributes.
        speech.text = message;
        speech.volume = 1;
        speech.rate = 1;
        speech.pitch = 1;
        
        window.speechSynthesis.speak(speech);
      }



      /*-----------------------------
            Helper Functions 
      ------------------------------*/

      function renderNotes(notes) {
        var html = '';
        if(notes.length) {
          notes.forEach(function(note) {
            html+= `<li class="note">
              <p class="header">
                <span class="date">${note.date}</span>
                <a href="#" class="listen-note" title="Listen to Note">Listen to Note</a>
                <a href="#" class="delete-note" title="Delete">Delete</a>
              </p>
              <p class="content">${note.content}</p>
            </li>`;    
          });
        }
        else {
          html = '<li><p class="content">You don\'t have any notes yet.</p></li>';
        }
        notesList.html(html);
      }


      function saveNote(dateTime, content) {
        localStorage.setItem('note-' + dateTime, content);
      }


      function getAllNotes() {
        var notes = [];
        var key;
        for (var i = 0; i < localStorage.length; i++) {
          key = localStorage.key(i);

          if(key.substring(0,5) == 'note-') {
            notes.push({
              date: key.replace('note-',''),
              content: localStorage.getItem(localStorage.key(i))
            });
          } 
        }
        return notes;
      }


      function deleteNote(dateTime) {
        localStorage.removeItem('note-' + dateTime); 
      }



    });
  }
};

var UserMedicationsShowPage = {
  template: "#user-medications-show-page",
  data: function() {
    return {
      user_medication: {
        id: "",
        dosage: "",
        user_id: "",
        provider: {
          name: "",
          address: ""
        },
        medication: {
          id: "",
          name: ""
        }
      },
      time_increment: "",
      increment_unit: "",
      repeating: ""
    };
  },
  created: function() {
    axios.get("/user_medications/" + this.$route.params.id)
    .then(function(response) {
      this.user_medication = response.data;
    }.bind(this));
  },
  methods: {
    submitTimer: function() {
      var params = {
        time_increment: this.time_increment,
        increment_unit: this.increment_unit,
        timerable_id: this.user_medication.id,
        timerable_type: "UserMedication",
        repeating: this.repeating
      };
      axios
        .post("/timers", params)
        .then(function(response) {
          router.push("/user");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};

var TimersNewPage = {
  template: "#timers-new-page",
  data: function() {
    return {
      time_increment: "",
      increment_unit: "",
      timerable_id: "",
      timerable_type: "",
      repeating: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        time_increment: this.time_increment,
        increment_unit: this.increment_unit,
        timerable_id: this.timerable_id,
        timerable_type: this.timerable_type,
        repeating: this.repeating
      };
      axios
        .post("/timers/", params)
        .then(function(response) {
          router.push("/timers");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};

var LogoutPage = {
  created: function() {
    axios.defaults.headers.common["Authorization"] = undefined;
    localStorage.removeItem("jwt");
    router.push("/");
  }
};

var router = new VueRouter({
  routes: [{ path: "/", component: HomePage },
    { path: "/signup", component: SignupPage },
    { path: "/login", component: LoginPage },
    { path: "/user", component: ViewProfilePage },
    { path: "/user_medications/:id", component: UserMedicationsShowPage},
    { path: "/logout", component: LogoutPage }    
  ],
  scrollBehavior: function(to, from, savedPosition) {
    return { x: 0, y: 0 };
  }
});

var app = new Vue({
  el: "#vue-app",
  router: router,
  data: function() {
    return {
      email: "",
      password: "",
      firstName: "",
      lastName: "",
      dob: "",
      streetAddress: "",
      city: "",
      state: "",
      zip: "",
      phoneNumber: "",
      passwordConfirmation: "",
      errors: []
    };
  },
  created: function() {
    var jwt = localStorage.getItem("jwt");
    if (jwt) {
      axios.defaults.headers.common["Authorization"] = jwt;
    }
  },
  methods: {
    loginSubmit: function() {
      var params = {
        auth: { email: this.email, password: this.password }
      };
      axios
        .post("/user_token", params)
        .then(function(response) {
          axios.defaults.headers.common["Authorization"] =
            "Bearer " + response.data.jwt;
          localStorage.setItem("jwt", response.data.jwt);
          router.push("/user");
        })
        .catch(
          function(error) {
            this.errors = ["Invalid email or password."];
            this.email = "";
            this.password = "";
          }.bind(this)
        );
    },
    signupSubmit: function() {
      var params = {
        first_name: this.firstName,
        last_name: this.lastName,
        dob: this.dob,
        street_address: this.streetAddress,
        city: this.city,
        zip: this.zip,
        phone_number: this.phoneNumber,
        email: this.email,
        password: this.password,
        password_confirmation: this.passwordConfirmation
      };
      axios
        .post("/users", params)
        .then(function(response) {
          router.push("/login");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
});