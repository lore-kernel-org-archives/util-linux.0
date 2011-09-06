Return-Path: heiko.carstens@de.ibm.com
Message-Id: <20110906010201.575705590@de.ibm.com>
Date: Tue, 06 Sep 2011 02:53:02 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 11/11] [PATCH] lscpu: add Hypervisor to output
References: <20110906005251.497675140@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

Some vendors have several hypervisors. Therefore it makes sense to not only
print out the hypervisor vendor but also the name of the hypervisor.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lscpu.c                    |   20 ++++++++++++++++++++
 tests/expected/lscpu/lscpu-s390-lpar |    1 +
 tests/expected/lscpu/lscpu-s390-zvm  |    1 +
 3 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 7923cc2..6049c3f 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -138,6 +138,7 @@ struct lscpu_desc {
 	char	*family;
 	char	*model;
 	char	*virtflag;	/* virtualization flag (vmx, svm) */
+	char	*hypervisor;	/* hypervisor software */
 	int	hyper;		/* hypervisor vendor ID */
 	int	virtype;	/* VIRT_PARA|FULL|NONE ? */
 	char	*mhz;
@@ -666,14 +667,31 @@ read_hypervisor(struct lscpu_desc *desc)
 		char buf[BUFSIZ];
 
 		desc->hyper = HYPER_IBM;
+		desc->hypervisor = "PR/SM";
 		desc->virtype = VIRT_FULL;
 		while (fgets(buf, sizeof(buf), fd) != NULL) {
+			char *str;
+
 			if (!strstr(buf, "Control Program:"))
 				continue;
 			if (!strstr(buf, "KVM"))
 				desc->hyper = HYPER_IBM;
 			else
 				desc->hyper = HYPER_KVM;
+			str = strchr(buf, ':');
+			if (!str)
+				continue;
+			if (asprintf(&str, str + 1) == -1)
+				errx(EXIT_FAILURE, _("failed to allocate memory"));
+			/* remove leading, trailing and repeating whitespace */
+			while (*str == ' ')
+				str++;
+			desc->hypervisor = str;
+			str += strlen(str) - 1;
+			while ((*str == '\n') || (*str == ' '))
+				*(str--) = '\0';
+			while (str = strstr(desc->hypervisor, "  "))
+				memmove(str, str + 1, strlen(str));
 		}
 		fclose(fd);
 	}
@@ -1259,6 +1277,8 @@ print_readable(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 		else if (!strcmp(desc->virtflag, "vmx"))
 			print_s(_("Virtualization:"), "VT-x");
 	}
+	if (desc->hypervisor)
+		print_s(_("Hypervisor:"), desc->hypervisor);
 	if (desc->hyper) {
 		print_s(_("Hypervisor vendor:"), hv_vendors[desc->hyper]);
 		print_s(_("Virtualization type:"), virt_types[desc->virtype]);
diff --git a/tests/expected/lscpu/lscpu-s390-lpar b/tests/expected/lscpu/lscpu-s390-lpar
index 600fd3f..0799ab9 100644
--- a/tests/expected/lscpu/lscpu-s390-lpar
+++ b/tests/expected/lscpu/lscpu-s390-lpar
@@ -8,6 +8,7 @@ Socket(s) per book:    6
 Book(s):               4
 Vendor ID:             IBM/S390
 BogoMIPS:              14367.00
+Hypervisor:            PR/SM
 Hypervisor vendor:     IBM
 Virtualization type:   full
 Dispatching mode:      vertical
diff --git a/tests/expected/lscpu/lscpu-s390-zvm b/tests/expected/lscpu/lscpu-s390-zvm
index 9ce22d4..04dcf76 100644
--- a/tests/expected/lscpu/lscpu-s390-zvm
+++ b/tests/expected/lscpu/lscpu-s390-zvm
@@ -7,6 +7,7 @@ Socket(s) per book:    1
 Book(s):               4
 Vendor ID:             IBM/S390
 BogoMIPS:              14367.00
+Hypervisor:            z/VM 6.1.0
 Hypervisor vendor:     IBM
 Virtualization type:   full
 Dispatching mode:      horizontal
-- 
1.7.5.4
