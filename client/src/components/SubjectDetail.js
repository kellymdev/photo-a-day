import React, { Component } from 'react';
import Photo from './Photo';
import PhotoForm from './PhotoForm';
import EditPhotoForm from './EditPhotoForm';

class SubjectDetail extends Component {
  constructor() {
    super();
    this.state = {showForm: false,
                  editingPhotoId: null};
    this.handlePhotoClick = this.handlePhotoClick.bind(this);
    this.handleEditPhotoSubmit = this.handleEditPhotoSubmit.bind(this);
  }

  displayPhotoForm = () => {
    this.setState({showForm: true});
  }

  hidePhotoForm = (photo) => {
    this.setState({showForm: false});
    this.props.onSubmit(photo.category.id);
  }

  handlePhotoClick = (id) => {
    this.setState({editingPhotoId: id});
  }

  handleEditPhotoSubmit = (photo) => {
    this.setState({editingPhotoId: null});
    this.props.onSubmit(photo.category.id);
  }

  render() {
    return (
      <div>
        <div className="add-photo">
          {this.state.showForm ? (
            <PhotoForm subjectId={this.props.subject.subject.id} onSubmit={this.hidePhotoForm} />
          ) : (
            <button className="add-photo-button" onClick={this.displayPhotoForm}>Add Photo</button>
          )}
        </div>

        <div className="photos">
          {this.props.subject.photos.map(photo =>
            this.state.editingPhotoId === photo.id ? (
              <EditPhotoForm date={photo.date} imageUrl={photo.image_url} notes={photo.notes} subjectId={this.props.subject.subject.id} photoId={photo.id} key={photo.id} onSubmit={this.handleEditPhotoSubmit} />
            ) : (
              <Photo photo={photo} subjectName={this.props.subject.subject.name} key={photo.id} onClick={this.handlePhotoClick} />
            )
          )}
        </div>
      </div>
    )
  }
}

export default SubjectDetail;