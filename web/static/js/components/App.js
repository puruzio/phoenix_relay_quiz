
import React from 'react';
import Relay from 'react-relay';
import Quiz from './Quiz';
import UserLogin from './UserLogin';
import UserCreate from './UserCreate';
import { debounce } from 'lodash';
import CreateQuizMutation from '../mutations/CreateQuizMutation';
import Modal from 'react-modal';
// import $ from 'jquery';

const customStyles = {
  content : {
    top                   : '50%',
    left                  : '50%',
    right                 : 'auto',
    bottom                : 'auto',
    marginRight           : '-50%',
    transform             : 'translate(-50%, -50%)'
  }
};

class App extends React.Component {
  static propTypes = {
    limit: React.PropTypes.number,
  }

  constructor(props) {
    super(props);
    
    this.search = debounce(this.search,300);
    this.state = {
        modalIsOpen: false,
        modalIsOpen1: false,
        modalIsOpen2: false
    }

    this.openModal1 = this.openModal1.bind(this);
    this.closeModal1 = this.closeModal1.bind(this);
    this.openModal2 = this.openModal2.bind(this);
    this.closeModal2 = this.closeModal2.bind(this);
  }

  handleSearch = (e) => {
    this.search(e.target.value);
  };

  search = (query) => {
   this.props.relay.setVariables({ query });
  };

  handleSetLimit = (e) => {
    const newLimit = Number(e.target.value);
    this.props.relay.setVariables({limit: newLimit});
  }

  handleSubmit = (e) => {
    e.preventDefault();
    const onSuccess = () => {
      $('#modal').closeModal();
    };

    const onFailure = (transaction) => {
      const error = transaction.getError() || new Error('Mutation failed.');
      console.log(error);
    };

    Relay.Store.commitUpdate(
      new CreateQuizMutation({
        question: this.newQuestion.value,
        choices: this.newChoices.value,
        author: $("#current_user").text(),
        categories: this.newCategories.value,
        mediaUrl: this.newMediaUrl.value,
        typeCode: this.newTypeCode.value,
        store: this.props.store,

      }),
      { onFailure, onSuccess }
    );

    this.newQuestion.value = '';
    this.newChoices.value = '';
  }

  openModal1 () {
    this.setState({modalIsOpen1: true});
  }

  afterOpenModal1 () {
    // references are now sync'd and can be accessed.
    this.refs.subtitle.style.color = '#f00';
  }

  closeModal1 ()  {
    this.setState({modalIsOpen1: false});
  }


  openModal2 () {
    this.setState({modalIsOpen2: true});
  }

  afterOpenModal2 () {
    // references are now sync'd and can be accessed.
    this.refs.subtitle.style.color = '#f00';
  }

  closeModal2 ()  {
    this.setState({modalIsOpen2: false});
  }

  componentDidMount() {
    $('.modal-trigger').leanModal();
  }

  render() {
    const edges = this.props.store.quizConnection.edges;
    const content = edges.map((edge) => {
      return (
          <Quiz
              key={edge.node.id}
              quiz={edge.node}
          />
      );
    });

    return (
        <div>
            <div className="input-field">
                <input
                    id="search"
                    type="text"
                    onChange={this.handleSearch}
                />
                <label htmlFor="search">Search All Resources</label>
            </div>

           <Modal
                isOpen={this.state.modalIsOpen1}
                onAfterOpen={this.afterOpenModal1}
                onRequestClose={this.closeModal1}
                style={customStyles} >

                <UserLogin onSuccessFunc = {this.closeModal1}/>
            </Modal>

            <Modal
                isOpen={this.state.modalIsOpen2}
                onAfterOpen={this.afterOpenModal2}
                onRequestClose={this.closeModal2}
                style={customStyles} >

                <UserCreate onSuccessFunc = {this.closeModal2}/>
            </Modal>
            
            <div className="row">

               {/*} <UserLogin />
                <UserCreate /> {*/}
                <a className="waves-effect waves-light btn right light-blue white-text"  onClick={this.openModal2}   href="#modal2">
                 Register
                </a>
                
                <a className="waves-effect waves-light btn right light-blue white-text" onClick={this.openModal1} >
                 Login
                </a>

                <a className="waves-effect waves-light btn modal-trigger right light-blue white-text"       href="#modal">
                 Yay! Add New Quiz!
                </a>
             
            </div>

            <ul>
              {content}
            </ul>

            <div className="row">
                <div className="col m9 s12">
                    <div className="flow-text">
                        <a
                            href="https://twitter.com/RGRjs"
                            target="_blank"
                        >
                          @RGRjs
                        </a>
                    </div>
                </div>
                <div className="col m3 hide-on-small-only">
                    <div className="input-field">
                        <select
                            className="browser-default"
                            defaultValue={this.props.relay.variables.limit}
                            id="showing"
                            onChange={this.handleSetLimit}
                        >
                            <option value="10">Show 10</option>
                            <option value="25">Show 25</option>
                            <option value="50">Show 50</option>
                            <option value="100">Show 100</option>
                        </select>
                    </div>
                </div>
            </div>

            <div
                className="modal modal-fixed-footer"
                id="modal"
            >
                <form onSubmit={this.handleSubmit}>
                    <div className="modal-content">
                        <h5>Add New Quiz</h5>
                        <div className="input-field">
                            <input
                                className="validate"
                                id="newQuestion"
                                ref={(c) => (this.newQuestion = c)}
                                required
                                type="text"
                            />
                            <label htmlFor="newQuestion">
                              Quiz
                            </label>
                        </div>
                    
                        <div className="input-field">
                            <input
                                className="validate"
                                id="newChoices"
                                ref={(c) => (this.newChoices = c)}
                                required
                                type="text"
                            />
                            <label htmlFor="newChoices">
                              Answer
                            </label>
                        </div>
                        <div className="input-field">
                            <input
                                className="validate"
                                id="newCategories"
                                ref={(c) => (this.newCategories = c)}
                                required
                                type="text"
                            />
                            <label htmlFor="newCategories">
                              Categories
                            </label>
                        </div>
                        <div className="input-field">
                            <input
                                className="validate"
                                id="newMediaUrl"
                                ref={(c) => (this.newMediaUrl = c)}
                                required
                                type="text"
                            />
                            <label htmlFor="newMediaUrl">
                              Media URL (e.g., http://blahblah.com/img/img01.jpg)
                            </label>
                        </div>
                        <div className="input-field">
                            <input
                                className="validate"
                                id="newTypeCode"
                                ref={(c) => (this.newTypeCode = c)}
                                required
                                type="text"
                            />
                            <label htmlFor="newTypeCode">
                              Type Code
                            </label>
                        </div>
                    </div>
                    <div className="modal-footer">
                        <button
                            className="waves-effect waves-green btn-flat green darken-3 white-text"
                            type="submit"
                        >
                            <strong>
                              Add
                            </strong>
                        </button>
                        <a
                            className="modal-action modal-close waves-effect waves-red btn-flat"
                            href="#!"
                        >
                          Cancel
                        </a>
                    </div>
                </form>
            </div>



        </div>
      );
  }
}

export default Relay.createContainer(App, {
  initialVariables:{
    limit: 15,
    query: '',
  },
  fragments: {
    store: () => {
      return Relay.QL`
        fragment on Store {
          id,
          quizConnection(first: $limit, query: $query) {
            edges{
              node{
                id,
                ${Quiz.getFragment('quiz')}
              }
            }
          },
          userConnection(first: $limit, query: $query) {
            edges{
              node{
                id,
                ${UserLogin.getFragment('user')}
              }
            }
          }
        }
      `;
    },
  },
});
