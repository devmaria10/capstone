/* global Vue, VueRouter, axios */

var HomePage = {
  template: "#home-page",
  data: function() {
    return {
      message: "Welcome to MyCancerCoach!"
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
      first_name: "",
      last_name: "",
      dob: "",
      street_address: "",
      city: "",
      state: "",
      zip: "",
      phone_number: "",
      email: "",
      password: "",
      passwordConfirmation: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        first_name: this.first_name,
        last_name: this.last_name,
        dob: this.dob,
        street_address: this.street_address,
        city: this.city,
        zip: this.zip,
        phone_number: this.phone_number,
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

var LogoutPage = {
  created: function() {
    axios.defaults.headers.common["Authorization"] = undefined;
    localStorage.removeItem("jwt");
    router.push("/");
  }
};

var CreateReminderPage = {
  template: "#create-reminder-page",
  data: function() {
    return {
      last_rang: "",
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
        last_rang: this.last_rang,
        time_increment: this.time_increment,
        increment_unit: this.increment_unit,
        timerable_id: this.timerable_id,
        timerable_type: this.timerable_type
      };
      axios
        .post("/timers", params)
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

var ViewProfilePage = {
  template: "#view-profile-page",
  data: function() {
    return {
      user: {
        id: "",
        first_name: "",
        last_name: "",
        dob: "",
        street_address: "",
        city: "",
        state: "",
        zip: "",
        phone_number: "",
        email: ""       
        }
      }
    }
  },
  created: function() {
    axios.get("/users/" + this.$route.params.id )
      .then(function(response) {
        this.user = response.data;
      }.bind(this));
  }
};


var router = new VueRouter({
  routes: [{ path: "/", component: HomePage },
    { path: "/signup", component: SignupPage },
    { path: "/login", component: LoginPage },
    { path: "/logout", component: LogoutPage },
    { path: "/timers", component: CreateReminderPage },
    { path: "/users", component: ViewProfilePage }
  ],
  scrollBehavior: function(to, from, savedPosition) {
    return { x: 0, y: 0 };
  }
});

var app = new Vue({
  el: "#vue-app",
  router: router, 
  created: function() {
    var jwt = localStorage.getItem("jwt");
    if (jwt) {
      axios.defaults.headers.common["Authorization"] = jwt;
    }
  }
});
