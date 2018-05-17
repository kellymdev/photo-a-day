import React, { Component } from 'react';

class Photo extends Component {
  render() {
    const imageAltText = this.props.subjectName + ' photo';

    return(
      <div className="photo-details">
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