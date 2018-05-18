import React, { Component } from 'react';

class Subject extends Component {
  handleClick = () => {
    this.props.onClick(this.props.subject.id)
  }

  render() {
    let classes = 'subject-name';
    classes += this.props.selected ? ' selected' : ''

    return (
      <li className={classes} onClick={this.handleClick}>{this.props.subject.name}</li>
    )
  }
}

export default Subject;