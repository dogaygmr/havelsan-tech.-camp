import apt
import apt_pkg
import re



apt_pkg.init_config()
apt_pkg.init_system()
cache  = apt_pkg.Cache()     
ipacks = [pack for pack in cache.packages] 

pattern = re.compile(r'^libboost-python')
cached = [pack for pack in ipacks if pattern.match(pack.name)]


# install check..
pack_installed = [pack for pack in cached if pack.current_state == apt_pkg.CURSTATE_INSTALLED]

if len(pack_installed) > 0:
        print ("installed names and version strings")
        [(pack.name, pack.current_ver.ver_str) for pack in pack_installed] 


allpack  = apt_pkg.Cache()

print(apt_pkg.Dependency.all_targets( ))
