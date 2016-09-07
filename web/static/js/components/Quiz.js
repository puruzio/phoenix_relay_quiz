import React from 'react';
import Relay from 'react-relay';
import moment from 'moment';
import urlPrettify from '../shared/urlPrettify';
import "./link_jo.css";
import $ from 'jquery';

class Quiz extends React.Component {
  dateStyle = () => ({
    color: '#888',
    fontSize: '0.7em',
    marginRight: '0.5em',
  });

  urlStyle = () => ({
    color: '#062',
    fontSize: '0.85em',
  });

  choiceStyle = () => ({
    color: 'purple',
    fontSize: '0.85em',
    display: 'block'
  });

  dateLabel = () => {
    const { quiz , relay } = this.props;
    if (relay.hasOptimisticUpdate(quiz)) {
      return 'Saving...';
    }
    return moment(quiz.createdAt).format('L');
  };

  render() {
    let { quiz } = this.props;

    var choices = [];
    if (quiz.choices) {
      choices = quiz.choices.split(',');
    } else {
      choices = ['Yes','No'];
    } 

    var categories = [];
    if (quiz.categories) {
      console.log(quiz.categories);
      categories = quiz.categories.split(',');
    } else {
      categories = ['uncategorized'];
    } 

    // let choices = this.props.comment || ["Choice 1", "Choice 2", "Choice 3"]
    let choice_buttons = choices.map((choice) => {
      return (
        <div>
        <a key = {choice} className="waves-effect waves-light btn modal-trigger right light-orange white-text"       href="#">
                 {choice}
                </a>
        </div>
      );
    });

    let categoryButtons = categories.map((category) => {
      return (
        <button type = "button" key = {category} class = "btn-floating green"> {category} </button>
      );
    });


    return (
        <li id="container_link">
            <div
                className="card-panel"
                style={{ padding: '1em' }}
            >
                <a
                    href={quiz.question}
                    target="_blank"
                >
                  <h4> {quiz.question} </h4>
                </a>
                <span>
                 <img
                    src={quiz.mediaUrl || 'https://unsplash.it/200/200?random'}
                    alt = {quiz.question}
                    class ="img-responsive"/>
                </span>
                <div className="truncate">
                    <span style={this.dateStyle()}>
                      {this.dateLabel()}
                    </span>
                    <span>
                      by {quiz.author || 'anonymous'}
                    </span>
                    <span>
                      {categoryButtons}
                    </span>
                </div>
                <div>
                  <span style={this.choiceStyle()}>
                      {/*}{quiz.choices} {*/}
                      {choice_buttons}
                    </span>
                </div>
            </div>
        </li>
    );
  }
}

export default Relay.createContainer(Quiz, {
  fragments:{
    quiz: () => {
      return Relay.QL`
        fragment on Quiz {
          question,
          choices,
          author,
          categories (first: 1000) {
            edges {
              node {
                category
              }
            }
          }
          mediaUrl,
          typeCode,
          createdAt,
          id
        }
      `;
    },
  },
});
