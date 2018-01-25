var Category = createReactClass({
  propTypes: {
    id: PropTypes.number,
    name: PropTypes.string
  },

  render: function() {
    return (
      <div>
        <div id={this.props.id}>{this.props.name}</div>
      </div>
    );
  }
});

