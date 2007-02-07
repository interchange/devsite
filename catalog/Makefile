#!/usr/bin/make

all: message

.SILENT:
COMMIT = cvs commit
PUBLISH = ssh icdevgroup.org sudo /root/update-devsite-cvs.sh
RESTART = ssh icdevgroup.org sudo /root/update-devsite-cvs.sh -r

message:
	echo
	echo "Make target           Performed function"
	echo "--------------------------------------------------------------------------"
	echo "commit                $(COMMIT)"
	echo "publish               $(PUBLISH)"
	echo "restart               $(RESTART)"
	echo

commit:
	$(COMMIT)

publish:
	$(PUBLISH)

restart:
	$(RESTART)

