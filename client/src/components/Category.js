import React, { Component } from 'react';

class Category extends Component {
  render() {
    return <p className="category-name">{this.props.category.name}</p>
  }
}

export default Category;