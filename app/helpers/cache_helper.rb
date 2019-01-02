module CacheHelper
  def digest_for_cache(value)
    Digest::MD5.hexdigest(value.to_s)
  end

  def params_for_cache
    params.permit!.to_h
  end
end
