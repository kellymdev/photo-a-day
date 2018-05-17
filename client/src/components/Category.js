import React, { Component } from 'react';

class Category extends Component {
  handleClick = () => {
    this.props.onClick(this.props.category.id)
  }

  render() {
    return <li className="category-name" onClick={this.handleClick}>{this.props.category.name}</li>
  }
}

export default Category;