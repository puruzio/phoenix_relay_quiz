
import Relay from 'react-relay';

class CreateQuizMutation extends Relay.Mutation {

    static fragments = {

    user: () => Relay.QL`fragment on User {
      id,
      quizzes {
        count,
      }
    }`
  };

  getMutation() {
    return Relay.QL`
      mutation { createQuiz }
      `;
  }

  getVariables() {
    return {
      question: this.props.question,
      complete: false,
      user: this.props.user.id,
    };
  }

  getFatQuery() {
    return Relay.QL`
      fragment on CreateQuizPayload {
        quizEdge,
        store { quizConnection },
        user {
          id,
          quizzes {
            count
          }
        },
      }
    `;
  }

  getConfigs() {
    return [{
      type: 'RANGE_ADD',
      parentName: 'store',
      parentID: this.props.store.id,
      connectionName: 'quizConnection',
      edgeName: 'quizEdge',
      rangeBehaviors: {
        '': 'prepend',
      },
    }];
  }

  getOptimisticResponse() {
    return {
      quizEdge: {
        node: {
          question: this.props.question,
          complete: false,
        },
      },
    };
  }
}

export default CreateQuizMutation;
