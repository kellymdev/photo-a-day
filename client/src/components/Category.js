import React, { Component } from 'react';

class Category extends Component {
  handleClick = () => {
    this.props.onClick(this.props.category.id)
  }

  render() {
    return <p className="category-name" onClick={this.handleClick}>{this.props.category.name}</p>
  }
}

export default Category;