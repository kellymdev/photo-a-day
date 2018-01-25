var CategoryList = createReactClass({
  propTypes: {
    categories: PropTypes.array
  },

  renderCategory(id, name) {
    return (
      <Category
        id={id}
        name={name}
      />
    );
  },

  render: function() {
    return (
      <div>
        <ul>
          {this.props.categories.map(function(category, index) {
            return <li key={index} id={category.id}>{category.name}</li>;
          })}
        </ul>
      </div>
    );
  }
});

