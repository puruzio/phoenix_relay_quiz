
import Relay from 'react-relay';

class CreateQuizMutation extends Relay.Mutation {

  getMutation() {
    return Relay.QL`
      mutation { createQuiz }
      `;
  }

  getVariables() {
    return {
      question: this.props.question,
      choices: this.props.choices,
    };
  }

  getFatQuery() {
    return Relay.QL`
      fragment on CreateQuizPayload {
        quizEdge,
        store { quizConnection }
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
          choices: this.props.choices
        },
      },
    };
  }
}

export default CreateQuizMutation;
