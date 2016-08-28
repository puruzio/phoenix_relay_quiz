
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
      author: this.props.author,
      categories: this.props.categories,
      mediaUrl: this.props.mediaUrl,
      typeCode: this.props.typeCode,
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
          choices: this.props.choices,
          author: this.props.author,
          categories: this.props.categories,
          mediaUrl: this.props.mediaUrl,
          typeCode: this.props.typeCode,
        },
      },
    };
  }
}

export default CreateQuizMutation;
