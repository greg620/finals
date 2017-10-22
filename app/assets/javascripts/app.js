(function($) {

    var modal = document.getElementById('modal');

    $('a[data-method="delete"]').click(function(e) {
        e.preventDefault();
        confirms = $(this).data('confirm');
        $('p.content').html(confirms);
        modal.style.display = 'block';
        var data_url = $('a.btn-delete').attr('href');
        $('a.data-url').attr('href', data_url);
    });

    $('.modals a.btn-close').click(function(e) {
        e.preventDefault();
        modal.style.display = 'none';
    });

    window.onclick = function() {
        if(event.target == modal) {
            modal.style.display = 'none';
        }
    }

    /*
    Lien pour les réponses
     */
    $('.reply').click(function(e) {
        e.preventDefault();
        var $this = $(this)
        var comment = $this.parents('.comment');
        var form = $('#new_comment');
        var id = $this.data('id');
        form.hide();
        comment.after(form);
        form.slideDown();
        $('#comment_parent_id').val(id);
        $('.cancel #cancel').html('Annuler');
    });
})(jQuery);