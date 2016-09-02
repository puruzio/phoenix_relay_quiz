
import Relay from 'react-relay';

class CreateCategoryMutation extends Relay.Mutation {

  getMutation() {
    return Relay.QL`
      mutation { createCategory }
      `;
  }

  getVariables() {
    return {
      category: this.props.category,
    };
  }

  getFatQuery() {
    return Relay.QL`
      fragment on CreateCategoryPayload {
        categoryEdge,
        store { categoryConnection}
      }
    `;
  }

  getConfigs() {
    return [
    {
      type: 'RANGE_ADD',
      parentName: 'store',
      parentID: this.props.store.id,
      connectionName: 'categoryConnection',
      edgeName: 'categoryEdge',
      rangeBehaviors: {
        '': 'prepend',
      },
    }
    ];
  }

  getOptimisticResponse() {
    return {
       categoryEdge: {
        node: {
          id: this.props.id,
          category: this.props.category,
          categoryType: this.props.categoryType,
        },
      },
    };
  }
}

export default CreateCategoryMutation;
