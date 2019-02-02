module FlashesHelper
  FLASH_CLASSES = { alert: 'danger', notice: 'success', warning: 'warning', recaptcha_error: 'warning'}.freeze

  def flash_class(key)
    FLASH_CLASSES.fetch key.to_sym, key
  end

  def user_facing_flashes
    flash.to_hash.slice 'alert', 'notice', 'warning', 'recaptcha_error'
  end
end
