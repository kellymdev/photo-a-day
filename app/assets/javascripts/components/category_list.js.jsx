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

  handleCategoryClick: function(e) {
    e.preventDefault();
    alert('Link clicked');
  },

  render: function() {
    return (
      <div>
        <ul>
          {this.props.categories.map(function(category, index) {
            return <li key={index} id={category.id} className="category-list-item"><a href="#" onClick={this.handleCategoryClick}>{category.name}</a></li>;
          })}
        </ul>
      </div>
    );
  }
});

