import React, { Component } from 'react';

class Photo extends Component {
  handleClick = () => {
    this.props.onClick(this.props.photo.id);
  }

  render() {
    const imageAltText = this.props.subjectName + ' photo';

    return(
      <div className="photo-details" onClick={this.handleClick}>
        { this.props.photo.image_url !== null ? (
          <div className="photo-image">
            <img alt={imageAltText} src={this.props.photo.image_url} />
          </div>
        ) : (
          <div className="no-image"></div>
        )}
        <p className="image-date">{this.props.photo.date}</p>
        <p className="image-description">{this.props.photo.notes}</p>
      </div>
    )
  }
}

export default Photo;