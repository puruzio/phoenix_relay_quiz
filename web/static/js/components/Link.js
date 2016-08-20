import React from 'react';
import Relay from 'react-relay';
import moment from 'moment';
import urlPrettify from '../shared/urlPrettify';
import "./link_jo.css"

class Link extends React.Component {
  dateStyle = () => ({
    color: '#888',
    fontSize: '0.7em',
    marginRight: '0.5em',
  });

  urlStyle = () => ({
    color: '#062',
    fontSize: '0.85em',
  });

  commentStyle = () => ({
    color: 'purple',
    fontSize: '0.85em',
    display: 'block'
  });

  dateLabel = () => {
    const { link , relay } = this.props;
    if (relay.hasOptimisticUpdate(link)) {
      return 'Saveing...';
    }
    return moment(link.createdAt).format('L');
  };

  render() {
    let { link } = this.props;

    var choices = [];
    if (link.comment) {
    choices = link.comment.split(',');
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
                    href={link.url}
                    target="_blank"
                >
                  {link.title}
                </a>
                <div className="truncate">
                    <span style={this.dateStyle()}>
                      {this.dateLabel()}
                    </span>
                    <a
                        href={link.url}
                        style={this.urlStyle()}
                    >
                      {urlPrettify(link.url)}
                    </a>
                </div>
                <div>
                  <span style={this.commentStyle()}>
                      {/*}{link.comment} {*/}
                      {choice_buttons}
                    </span>
                </div>
            </div>
        </li>
    );
  }
}

export default Relay.createContainer(Link, {
  fragments:{
    link: () => {
      return Relay.QL`
        fragment on Link {
          url,
          title,
          comment,
          createdAt,
        }
      `;
    },
  },
});
