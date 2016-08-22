import React from 'react';
import Relay from 'react-relay';
import moment from 'moment';
import urlPrettify from '../shared/urlPrettify';
import "./link_jo.css"

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
                  {quiz.question}
                </a>
                <div className="truncate">
                    <span style={this.dateStyle()}>
                      {this.dateLabel()}
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
          createdAt,
          id
        }
      `;
    },
  },
});
