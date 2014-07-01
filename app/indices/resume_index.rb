ThinkingSphinx::Index.define :resume, :with => :active_record, :delta => ThinkingSphinx::Deltas::DelayedDelta do
  	indexes position 
  	indexes city
	indexes created_at, sortable: true
	where "resumes.state IN ('published', 'hot')"
end