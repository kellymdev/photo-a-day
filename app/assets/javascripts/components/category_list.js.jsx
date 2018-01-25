var CategoryList = createReactClass({
  propTypes: {
    categories: PropTypes.array
  },

  renderCategory(i) {
    return (
      <Category
        id={this.props.categories[i].id}
        name={this.props.categories[i].name}
      />
    );
  },

  render: function() {
    return (
      <div>
        {this.renderCategory(0)}
      </div>
    );
  }
});

