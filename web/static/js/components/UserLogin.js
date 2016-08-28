import React from 'react';
import Relay from 'react-relay';
import axios from 'axios';
import $ from 'jquery';

const UserLogin = React.createClass({
  componentDidMount() {
    // if (this.props.currentUser) {
    //   this.props.dispatch(pushState(null, "/"));
    // }
  },
  handleSubmit(e) {
    e.preventDefault();

    let self = this;

    let email = e.target.email.value;
    let password = e.target.password.value;

    let session = {
      email: email,
      password: password
    }

    axios.post('http://localhost:4000/api/v1/login', {session: session})
      .then(function(response) {
        if (response.status === 201) {
          // Save new JWT to localStorage
          localStorage.phoenix_auth_token = response.data.jwt;
          // self.props.dispatch(Actions.getCurrentUser());
            axios.get('http://localhost:4000/api/v1/current_user', {
              headers: {'Authorization': localStorage.phoenix_auth_token},
              params: {
                jwt: localStorage.phoenix_auth_token
              }
            })
              .then(function (response) {
                if (response.status === 200) {
                  // dispatch({
                  //   type: 'CURRENT_USER',
                    $("#current_user").text(response.data.data.username);
                    console.log('Current user: ' );
                    console.log(response.data.data.username);
                    console.log(response.data.data);
                  
                } else {
                    consnole.log('No logged in');
                }
              })

          // Route to home page
          // self.props.dispatch(pushState(null, '/'));
        } else {
          console.log("Failed login...");
          console.log(response);
        }
      })
      .catch(function(response) {
        console.log("Failed login...");
        console.log(response);
      });

      self.props.onSuccessFunc();
      // $('#modal1').closeModal1();
  },
  render () {
    console.log(this.props);
    return (
      <div className="container">
        <h4>Login</h4>
        <form onSubmit={this.handleSubmit}>
          <div className="form-group">
            <label htmlFor="email">Email</label>
            <input type="text" name="email" className="form-control email" />
          </div>
          <div className="form-group">
            <label htmlFor="password">Password</label>
            <input type="password" name="password" className="form-control password" />
          </div>
          <input type="submit" className="btn btn-default" />                   
        </form>
      </div>
    )
  }
});

// function mapStateToProps(state) {
//   return { 
//     currentUser: state.currentUser
//   }
// }


// export default connect(mapStateToProps)(UserLogin);
export default Relay.createContainer(UserLogin, {
  fragments:{
    user: () => {
      return Relay.QL`
        fragment on User {
          username,
          email,
          id          
        }
      `;
    },
  },
});