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
      increment_unit: ""
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
        timerable_type: "UserMedication"
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
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        time_increment: this.time_increment,
        increment_unit: this.increment_unit,
        timerable_id: this.timerable_id,
        timerable_type: this.timerable_type
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
    { path: "/timers/new", component: TimersNewPage },
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