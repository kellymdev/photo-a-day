import React, { Component } from 'react';
import Photo from './Photo';
import PhotoForm from './PhotoForm';
import EditPhotoForm from './EditPhotoForm';
import DeletePhoto from './DeletePhoto';

class SubjectDetail extends Component {
  constructor() {
    super();
    this.state = {showForm: false,
                  editingPhotoId: null};
    this.handlePhotoClick = this.handlePhotoClick.bind(this);
    this.handleEditPhotoSubmit = this.handleEditPhotoSubmit.bind(this);
    this.handleDelete = this.handleDelete.bind(this);
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

  handleDelete = (categoryId) => {
    this.props.onSubmit(categoryId);
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
          {this.props.subject.photos.map((photo, index) =>
            this.state.editingPhotoId === photo.id ? (
              <EditPhotoForm date={photo.date} imageUrl={photo.image_url} notes={photo.notes} subjectId={this.props.subject.subject.id} photoId={photo.id} key={photo.id} onSubmit={this.handleEditPhotoSubmit} />
            ) : (
              <div className="photo-panel" key={photo.id}>
                <Photo photo={photo} subjectName={this.props.subject.subject.name} onClick={this.handlePhotoClick} />
                <DeletePhoto photoId={photo.id} subjectId={this.props.subject.subject.id} onClick={this.handleDelete} />
              </div>
            )
          )}
        </div>
      </div>
    )
  }
}

export default SubjectDetail;