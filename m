Received: from mail-io1-f100.google.com (mail-io1-f100.google.com [209.85.166.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17CDA31
	for <util-linux@vger.kernel.org>; Sun, 31 Dec 2023 02:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Fii1dlkk"
Received: by mail-io1-f100.google.com with SMTP id ca18e2360f4ac-7bade847536so237259739f.0
        for <util-linux@vger.kernel.org>; Sat, 30 Dec 2023 18:09:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703988558; x=1704593358;
        h=content-transfer-encoding:message-id:date:subject:cc:to:from
         :dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4ww0cr3B/PlonGCG7BlyEkcC61RxrxGq2jYvatrflo=;
        b=FjnnGUyFOVxvXImNw4qARONlzZOdDoc1GCcwz1AoGNSjIVcRs8NumnSJhgpqKg3VFg
         5v7mnKCZXTTkMIJo5QOA0T93UvexWVnZzKlRemQstv9FomHQQfzyZvrNSR8F7RljyLOz
         ME6hNQpk82PwKwacwqMXWmYU57uydKov04n/2+jPb3dQV2vuk7gCGpWPDDzpmi87iem5
         +kE1Zmu1bEoUMGSl4SdN97l7VKOK+n0ey1Pid1hczJ4EqgNf3GpGri/BHPYUyryi1OfT
         0fdf7sjOjT0hW0Xx1cJg121oOu4KCUXCKkOOpuifUPHHG68gkjHvKn7/Xq1LltA9TL91
         Rf/g==
X-Gm-Message-State: AOJu0Yz2cByuvXfLE/HkjqxQ2FWijMikB7A4ZcXfUpUVhgd31JG/6uiy
	kGf4WDmG/LCdFOJVPHcdnKdPYwQkQcMTajRHmQHYz77bhVBWSAJ7DB8=
X-Google-Smtp-Source: AGHT+IEok73zPBhV3cnAFj8Mx3qLbS+254idtGWqIwospoBtk9Mmyk+JgCdfkbhBRZHRThugez0Kb/5J7fl5
X-Received: by 2002:a05:6e02:1d8c:b0:35d:62f2:1f45 with SMTP id h12-20020a056e021d8c00b0035d62f21f45mr22361828ila.20.1703988557764;
        Sat, 30 Dec 2023 18:09:17 -0800 (PST)
Received: from smtp.aristanetworks.com ([74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id e20-20020a17090a9a9400b0028cbca893f0sm209265pjp.9.2023.12.30.18.09.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Dec 2023 18:09:17 -0800 (PST)
X-Relaying-Domain: arista.com
X-SMTP-Authentication: Allow-List-permitted
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1703988557;
	bh=A4ww0cr3B/PlonGCG7BlyEkcC61RxrxGq2jYvatrflo=;
	h=From:To:Cc:Subject:Date:From;
	b=Fii1dlkkAXa3T3P8zOm0mrVogb2vKyMX0zedcOxUICpbYOQ5quSOFwV3XZD9SQAMo
	 tK3zftByz02bWuxwH7WsOLYTYRJVD3j0eHsMwjB2OWGgyuKiikSmeqUJR5UhvMV8oC
	 lb3H9DlOhXBUcRuOeiVf6wdFb3+dSN/NsVvYl1w3AKgOl9KNhrpBt3a2HL3pItwEAK
	 IpJ/+I5kcK9gKMCjG9nnDpT4bUwQRaxpRwIeDFYu06oqxsFVEHGfn0Iw//Ba6I1nJl
	 wuvo8GC2jd+ZtUQvnOWJkq3aTwd7rUdqQyRbumj5ba4xvaTjCiJFq9o1KoGf2WCCFj
	 dCFCTDZzNy88Q==
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Received: from us113.sjc.aristanetworks.com (us113.sjc.aristanetworks.com [10.242.240.8])
	by smtp.aristanetworks.com (Postfix) with ESMTP id 0C404402056;
	Sat, 30 Dec 2023 18:09:17 -0800 (PST)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Received: by us113.sjc.aristanetworks.com (Postfix, from userid 10383)
	id E279DB840957; Sat, 30 Dec 2023 18:09:16 -0800 (PST)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
From: Edward Chron <echron@arista.com>
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
To: util-linux@vger.kernel.org
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Cc: colona@arista.com,
	echron@arista.com,
	echron@gmail.com
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Subject: [PATCH] util-linux dmesg add PRINTK_CALLER support Issue:2609
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Date: Sat, 30 Dec 2023 18:09:08 -0800
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Message-ID: <20231231020908.7729-1-echron@arista.com>
X-SMTP-Authentication: Allow-List-permitted
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>

Submission to Project: util-linux
Open Incident: #2609 at github.com/util-linux/util-linux/issues/2609
Component: util-linux/sys-utils
File: dmesg.c
Code level patch applied against: 2.39.3 - latest code pulled from
           git.github.com:util-linux/util-linux.git
Revision: #1 on 2023/12/08 per Review from Karel Zak
Revision: #2 on 2023/12/12 Adjust line offsets for master update and
                           Add caller_id_size init to dmesg -K
Revision: #3 on 2023/12/12 Use of sizeof for cidbuf and limit search
                           for caller_id to dmesg prefix to msg text
Revision: #4 on 2023/12/15 Ensure SYSLOG and kmsg inputs have
                           caller_id_size set appropriately
Revision: #5 on 2023/12/24 Make caller_id width consistent with
                           makedumpfile
Revision: #6 on 2023/12/30 Use updated test naming convention

Add support to standard dmesg command for the optional Linux Kernel
debug CONFIG option PRINTK_CALLER which adds an optional dmesg field
that contains the Thread Id or CPU Id that is issuing the printk to
add the message to the kernel ring buffer. This makes debugging simpler
as dmesg entries for a specific thread or CPU can be recognized.

The dmesg -S using the old syslog interface supports printing the
PRINTK_CALLER field but currently standard dmesg does not support
printing the field if present. There are utilities that use dmesg and
so it would be optimal if dmesg supported PRINTK_CALLER as well.

The additional field provided by PRINTK_CALLER is only present
if it was configured for the Linux kernel where the dmesg command
is run. It is a debug option and not configured by default so the
dmesg output will only change for those kernels where the option was
configured when the kernel was built. For users who went to the
trouble to configure PRINTK_CALLER and have the extra field available
for debugging, having dmesg print the field is very helpful.

Size of the PRINTK_CALLER field is determined by the maximum number
tasks that can be run on the system which is limited by the value of
/proc/sys/kernel/pid_max as pid values are from 0 to value - 1.
This value determines the number of id digits needed by the caller id.
The PRINTK_CALLER field is printed as T<id> for a Task Id or C<id>
for a CPU Id for a printk in CPU context. The values are left space
padded and enclosed in parentheses such as: [    T123] or [     C16]

For consistency with dmesg -S which supports the PRINTK_CALLER field
the field is printed followed by a space. For JSON format output the
PRINTK_CALLER field is identified as caller as that is consistent with
it's naming in /dev/kmsg. No space padding is used to reduce space
consumed by the JSON output. So the output from the command on a system
with PRINTK_CALLER field enabled in the Linux .config file the dmesg
output appears as:

> dmesg
...
[  520.897104] [   T3919] usb 3-3: Product: USB 2.0 Hub

and

> dmesg -x
...
kern  :info  : [  520.897104] [   T3919] usb 3-3: Product: USB 2.0 Hub

and

> dmesg -J
...
      },{
         "pri": 6,
         "time":    520.897104,
         "caller": "T3919",
         "msg": "usb 3-3: Product: USB 2.0 Hub"
      },{

and

> dmesg -J -x
...
      },{
         "fac": "kern",
         "pri": "info",
         "time":   520.897104,
         "caller": "T3919",
         "msg": "usb 3-3: Product: USB 2.0 Hub"
      },{

>

For comparison:

> dmesg -S
...
[  520.897104] [ T3919] usb 3-3: Product: USB 2.0 Hub

and

> dmesg -S -x
...
kern  :info  : [  520.897104] [ T3919] usb 3-3: Product: USB 2.0 Hub

Note: When dmesg uses the old syslog interface the reserved space for
      the PRINTK_CALLER field is capped at 5 digits because 32-bit
      kernels are capped at 32768 as the max number of PIDs. However,
      64-bit systems are currently capped at 2^22 PIDs (0 - 4194303).
      The PID cap is set by PID_MAX_LIMIT but the system limit can be
      less so we use /proc/sys/kernel/pid_max to determine the size
      needed to hold the maximum PID value size for the current system.
      Many 64-bit systems support 2^22 PIDs (0 - 4194303) and you see:

> dmesg -x
...
kern  :info  : [  520.899558] [   T3919] hub 3-3:1.0: USB hub found
...
kern  :info  : [ 9830.456898] [  T98982] cgroup: fork rejected by pids ...
kern  :info  : [14301.158878] [ T137336] cgroup: fork rejected by pids ...
kern  :info  : [18980.803190] [T1637865] cgroup: fork rejected by pids ...

> dmesg -S -x
...
kern  :info  : [  520.899558] [ T3919] hub 3-3:1.0: USB hub found
...
kern  :info  : [ 9830.456898] [T98982] cgroup: fork rejected by pids ...
kern  :info  : [14301.158878] [T137336] cgroup: fork rejected by pids ...
kern  :info  : [18980.803190] [T1637865] cgroup: fork rejected by pids ...

This is the only difference seen with PRINTK_CALLER configured and
printing between the dmesg /dev/kmsg interface and the dmesg -S syslog
interface.

Tests naming has been revised based on naming convention Thomas used to
introduce dmest json tests. The naming of test and input files that
reside in tests/ts/dmeg include:

<name> are existing dmesg syslog interface tests and input files.
cid-<name> are dmesg syslog interface caller_id tests and input files.
json-<name> are dmesg kmsg interface tests and input files.
cid-json-<name> are dmesg kmsg interface caller_id tests and input files.

Resulting expected files match the test names.

Signed-off-by: Ivan Delalande <colona@arista.com>
Signed-off-by: Edward Chron <echron@arista.com>
---
 include/pathnames.h                    |   3 +
 sys-utils/dmesg.c                      | 128 ++++++++++++++++++++++++-
 tests/expected/dmesg/kmsg-file         | 126 ++++++++++++++++++++----
 tests/ts/dmesg/cid-input               | 106 ++++++++++++++++++++
 tests/ts/dmesg/cid-json                |  28 ++++++
 tests/ts/dmesg/cid-kmsg-colors         |  29 ++++++
 tests/ts/dmesg/cid-kmsg-console-levels |  36 +++++++
 tests/ts/dmesg/cid-kmsg-decode         |  28 ++++++
 tests/ts/dmesg/cid-kmsg-delta          |  28 ++++++
 tests/ts/dmesg/cid-kmsg-facilities     |  30 ++++++
 tests/ts/dmesg/cid-kmsg-indentation    |  40 ++++++++
 tests/ts/dmesg/cid-kmsg-input          | Bin 0 -> 4425 bytes
 tests/ts/dmesg/cid-kmsg-json           |  28 ++++++
 tests/ts/dmesg/cid-kmsg-limit          |  29 ++++++
 tests/ts/dmesg/cid-kmsg-newlines       | Bin 0 -> 152 bytes
 tests/ts/dmesg/kmsg-input              | Bin 1955 -> 3944 bytes
 16 files changed, 619 insertions(+), 20 deletions(-)
 create mode 100644 tests/ts/dmesg/cid-input
 create mode 100755 tests/ts/dmesg/cid-json
 create mode 100755 tests/ts/dmesg/cid-kmsg-colors
 create mode 100755 tests/ts/dmesg/cid-kmsg-console-levels
 create mode 100755 tests/ts/dmesg/cid-kmsg-decode
 create mode 100755 tests/ts/dmesg/cid-kmsg-delta
 create mode 100755 tests/ts/dmesg/cid-kmsg-facilities
 create mode 100755 tests/ts/dmesg/cid-kmsg-indentation
 create mode 100644 tests/ts/dmesg/cid-kmsg-input
 create mode 100755 tests/ts/dmesg/cid-kmsg-json
 create mode 100755 tests/ts/dmesg/cid-kmsg-limit
 create mode 100644 tests/ts/dmesg/cid-kmsg-newlines

diff --git a/include/pathnames.h b/include/pathnames.h
index caf0e63d4..81fa405f6 100644
--- a/include/pathnames.h
+++ b/include/pathnames.h
@@ -230,4 +230,7 @@
 /* cgroup path */
 #define _PATH_SYS_CGROUP	"/sys/fs/cgroup"
 
+/* Maximum number of PIDs system supports */
+#define _PATH_PROC_PIDMAX	"/proc/sys/kernel/pid_max"
+
 #endif /* PATHNAMES_H */
diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 77728b419..e27966b05 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -13,7 +13,9 @@
  */
 #include <stdio.h>
 #include <getopt.h>
+#include <stdbool.h>
 #include <stdlib.h>
+#include <string.h>
 #include <sys/klog.h>
 #include <sys/syslog.h>
 #include <sys/time.h>
@@ -41,6 +43,7 @@
 #include "mangle.h"
 #include "pager.h"
 #include "jsonwrt.h"
+#include "pathnames.h"
 
 /* Close the log.  Currently a NOP. */
 #define SYSLOG_ACTION_CLOSE          0
@@ -65,6 +68,12 @@
 /* Return size of the log buffer */
 #define SYSLOG_ACTION_SIZE_BUFFER   10
 
+#define PID_CHARS_MAX sizeof(stringify_value(LONG_MAX))
+#define PID_CHARS_DEFAULT sizeof(stringify_value(INT_MAX))
+#define SYSLOG_DEFAULT_CALLER_ID_CHARS sizeof(stringify_value(SHRT_MAX))-1
+#define DMESG_CALLER_PREFIX "caller="
+#define DMESG_CALLER_PREFIXSZ (sizeof(DMESG_CALLER_PREFIX)-1)
+
 /*
  * Color scheme
  */
@@ -233,6 +242,7 @@ struct dmesg_control {
 			force_prefix:1;	/* force timestamp and decode prefix
 					   on each line */
 	int		indent;		/* due to timestamps if newline */
+	size_t          caller_id_size;   /* PRINTK_CALLERID max field size */
 };
 
 struct dmesg_record {
@@ -242,6 +252,7 @@ struct dmesg_record {
 	int		level;
 	int		facility;
 	struct timeval  tv;
+	char		caller_id[PID_CHARS_MAX];
 
 	const char	*next;		/* buffer with next unparsed record */
 	size_t		next_size;	/* size of the next buffer */
@@ -254,6 +265,7 @@ struct dmesg_record {
 		(_r)->level = -1; \
 		(_r)->tv.tv_sec = 0; \
 		(_r)->tv.tv_usec = 0; \
+		(_r)->caller_id[0] = 0; \
 	} while (0)
 
 static int process_kmsg(struct dmesg_control *ctl);
@@ -551,6 +563,45 @@ static int get_syslog_buffer_size(void)
 	return n > 0 ? n : 0;
 }
 
+/*
+ * Get the number of characters needed to hold the maximum number
+ * of tasks this system supports. This size of string could hold
+ * a thread id large enough for the highest thread id.
+ * This is needed to determine the number of characters reserved for
+ * the PRINTK_CALLER field if it has been configured in the Linux Kernel.
+ *
+ * The number of digits sets the max value since the value can't exceed
+ * a value of that size. The /proc field defined by _PATH_PROC_PIDMAX
+ * holds the maximum number of PID values that may be ussed by the system,
+ * so 0 to that value minus one.
+ *
+ * For determining the size of the PRINTK_CALLER field, we make the safe
+ * assumption that the number of threads >= number of cpus. This because
+ * the PRINTK_CALLER field can hold either a thread id or a CPU id value.
+ *
+ * If we can't access the pid max kernel proc entry we assign a default
+ * field size of 5 characters as that is what the old syslog interface
+ * uses as the reserved field size. This is justified because 32-bit Linux
+ * systems are limited to PID values between (0-32767).
+ *
+ */
+static size_t max_threads_id_size(void)
+{
+	char taskmax[PID_CHARS_MAX] = {'\0'};
+	ssize_t rdsize;
+	int fd;
+
+	fd = open(_PATH_PROC_PIDMAX, O_RDONLY);
+	if (fd == -1)
+		return PID_CHARS_DEFAULT;
+
+	rdsize = read(fd, taskmax, sizeof(taskmax));
+	if (rdsize == -1)
+		return PID_CHARS_DEFAULT;
+
+	return strnlen(taskmax, sizeof(taskmax));
+}
+
 /*
  * Reads messages from regular file by mmap
  */
@@ -624,6 +675,8 @@ static ssize_t process_buffer(struct dmesg_control *ctl, char **buf)
 			ctl->bufsize = get_syslog_buffer_size();
 
 		n = read_syslog_buffer(ctl, buf);
+		/* Set number of PID characters for caller_id spacing */
+		ctl->caller_id_size = SYSLOG_DEFAULT_CALLER_ID_CHARS;
 		break;
 	case DMESG_METHOD_KMSG:
 		if (ctl->filename)
@@ -728,6 +781,39 @@ static const char *skip_item(const char *begin, const char *end, const char *sep
 	return begin;
 }
 
+/*
+ * Checks to see if the caller (caller id) field is present in the kmsg record.
+ * This is true if the PRINTK_CALLER config option has been set in the kernel.
+ *
+ * If the caller_id is found in the kmsg buffer then return the id and id type
+ * to the caller in dmesg caller_id. Returns string pointer to next value.
+ *
+ */
+static const char *parse_callerid(const char *p_str, const char *end,
+				  struct dmesg_record *p_drec)
+{
+	const char *p_after;
+	const char *p_next;
+	size_t cid_size;
+	char *p_scn;
+	char *p_cid;
+
+	/* Check for PRINTK_CALLER prefix, must be before msg text */
+	p_cid = strstr(p_str, DMESG_CALLER_PREFIX);
+	p_scn = strchr(p_str, ';');
+	if (p_cid != NULL && p_drec != NULL && p_scn != NULL && p_cid < p_scn) {
+		p_next = p_cid + DMESG_CALLER_PREFIXSZ;
+		p_after = skip_item(p_next, end, ",;");
+		cid_size = p_after - p_next;
+		if (cid_size < sizeof(p_drec->caller_id))
+			xstrncpy(p_drec->caller_id, p_next, cid_size);
+		else
+			return p_str;
+		return p_after;
+	}
+	return p_str;
+}
+
 /*
  * Parses one record from syslog(2) buffer
  */
@@ -795,8 +881,22 @@ static int get_next_syslog_record(struct dmesg_control *ctl,
 				begin++;
 		}
 
-		rec->mesg = begin;
-		rec->mesg_size = end - begin;
+		if (*begin == '[' && (*(begin + 1) == ' ' ||
+			(*(begin + 1) == 'T' || *(begin + 1) == 'C'))) {
+			const char *start = begin + 1;
+			size_t id_size;
+
+			start = start + strspn(start, " ");
+			begin = skip_item(begin, end, "]");
+			id_size = begin - start;
+			if (id_size < sizeof(rec->caller_id))
+				xstrncpy(rec->caller_id, start, id_size);
+			rec->mesg = begin + 1;
+			rec->mesg_size = end - begin - 1;
+		} else {
+			rec->mesg = begin;
+			rec->mesg_size = end - begin;
+		}
 
 		/* Don't count \n from the last message to the message size */
 		if (*end != '\n' && *(end - 1) == '\n')
@@ -1101,6 +1201,19 @@ full_output:
 			color_disable();
 	}
 
+	if (*rec->caller_id) {
+		if (ctl->json) {
+			ul_jsonwrt_value_s(&ctl->jfmt, "caller", rec->caller_id);
+		} else {
+			char cidbuf[PID_CHARS_MAX+3] = {'\0'};
+
+			sprintf(cidbuf, "[%*s] ",
+				(char)ctl->caller_id_size, rec->caller_id);
+			ctl->indent += strnlen(cidbuf, sizeof(cidbuf));
+			fputs(cidbuf, stdout);
+		}
+	}
+
 	/*
 	 * A kernel message may contain several lines of output, separated
 	 * by '\n'.  If the timestamp and decode outputs are forced then each
@@ -1284,7 +1397,10 @@ static int parse_kmsg_record(struct dmesg_control *ctl,
 		goto mesg;
 
 	/* D) optional fields (ignore) */
-	p = skip_item(p, end, ";");
+	p = skip_item(p, end, ",;");
+
+	/* Include optional PRINTK_CALLER field if it is present */
+	p = parse_callerid(p, end, rec);
 
 mesg:
 	/* E) message text */
@@ -1336,6 +1452,9 @@ static int process_kmsg(struct dmesg_control *ctl)
 	if (ctl->method != DMESG_METHOD_KMSG || ctl->kmsg < 0)
 		return -1;
 
+	/* Determine number of PID characters for caller_id spacing */
+	ctl->caller_id_size = max_threads_id_size();
+
 	/*
 	 * The very first read() call is done in kmsg_init() where we test
 	 * /dev/kmsg usability. The return code from the initial read() is
@@ -1446,6 +1565,7 @@ int main(int argc, char *argv[])
 		.kmsg = -1,
 		.time_fmt = DMESG_TIMEFTM_TIME,
 		.indent = 0,
+		.caller_id_size = 0,
 	};
 	int colormode = UL_COLORMODE_UNDEF;
 	enum {
@@ -1538,10 +1658,12 @@ int main(int argc, char *argv[])
 		case 'F':
 			ctl.filename = optarg;
 			ctl.method = DMESG_METHOD_MMAP;
+			ctl.caller_id_size = SYSLOG_DEFAULT_CALLER_ID_CHARS;
 			break;
 		case 'K':
 			ctl.filename = optarg;
 			ctl.method = DMESG_METHOD_KMSG;
+			ctl.caller_id_size = max_threads_id_size();
 			break;
 		case 'f':
 			ctl.fltr_fac = 1;
diff --git a/tests/expected/dmesg/kmsg-file b/tests/expected/dmesg/kmsg-file
index 54b5e612d..984588e3e 100644
--- a/tests/expected/dmesg/kmsg-file
+++ b/tests/expected/dmesg/kmsg-file
@@ -1,49 +1,77 @@
 {
    "dmesg": [
       {
-         "pri": 5,
+         "pri": 0,
          "time":     0.000000,
          "msg": "Linux version 6.6.4-arch1-1 (linux@archlinux) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Mon, 04 Dec 2023 00:29:19 +0000"
       },{
-         "pri": 6,
-         "time":     0.000000,
+         "pri": 1,
+         "time":     0.000001,
          "msg": "Command line: initrd=\\ucode.img initrd=\\initramfs-linux.img rw cryptdevice=/dev/nvme0n1p3:system:discard root=/dev/mapper/system"
       },{
-         "pri": 6,
-         "time":     0.000000,
+         "pri": 2,
+         "time":     0.000002,
          "msg": "BIOS-provided physical RAM map:"
       },{
-         "pri": 6,
-         "time":     0.000000,
+         "pri": 3,
+         "time":     0.000003,
          "msg": "BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable"
       },{
-         "pri": 6,
-         "time":     0.000000,
+         "pri": 4,
+         "time":     0.000004,
          "msg": "BIOS-e820: [mem 0x000000000009f000-0x00000000000bffff] reserved"
       },{
-         "pri": 6,
-         "time":     0.000000,
+         "pri": 5,
+         "time":     0.000005,
          "msg": "BIOS-e820: [mem 0x0000000000100000-0x0000000009afffff] usable"
       },{
          "pri": 6,
-         "time":     0.000000,
+         "time":     0.000006,
          "msg": "BIOS-e820: [mem 0x0000000009b00000-0x0000000009dfffff] reserved"
       },{
-         "pri": 6,
-         "time":     0.000000,
+         "pri": 7,
+         "time":     0.000007,
          "msg": "BIOS-e820: [mem 0x0000000009e00000-0x0000000009efffff] usable"
       },{
          "pri": 6,
-         "time":     0.000000,
+         "time":     0.000008,
          "msg": "BIOS-e820: [mem 0x0000000009f00000-0x0000000009f3bfff] ACPI NVS"
       },{
          "pri": 6,
-         "time":     0.000000,
+         "time":     0.000009,
          "msg": "BIOS-e820: [mem 0x0000000009f3c000-0x000000004235ffff] usable"
       },{
          "pri": 6,
-         "time":     0.000000,
+         "time":     0.000010,
          "msg": "BIOS-e820: [mem 0x0000000042360000-0x000000004455ffff] reserved"
+      },{
+         "pri": 6,
+         "time":     0.201607,
+         "msg": "smp: Bringing up secondary CPUs ..."
+      },{
+         "pri": 6,
+         "time":     0.201607,
+         "msg": "smpboot: x86: Booting SMP configuration:"
+      },{
+         "pri": 4,
+         "time":     0.209670,
+         "msg": "  #1  #3  #5  #7"
+      },{
+         "pri": 6,
+         "time":     0.212630,
+         "msg": "smp: Brought up 1 node, 16 CPUs"
+      },{
+         "pri": 5,
+         "time":     0.215936,
+         "msg": "audit: type=2000 audit(1702926179.015:1): state=initialized audit_enabled=0 res=1"
+      },{
+         "pri": 6,
+         "time":     0.215937,
+         "msg": "thermal_sys: Registered thermal governor 'fair_share'"
+      },{
+         "pri": 4,
+         "time":     0.215966,
+         "msg": "ENERGY_PERF_BIAS: Set to 'normal', was 'performance'"
       },{
          "pri": 6,
          "time":     0.367657,
@@ -88,6 +116,70 @@
          "pri": 6,
          "time":     0.378461,
          "msg": "pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]"
+      },{
+         "pri": 13,
+         "time":     9.398562,
+         "msg": "user network daemon initialization complete"
+      },{
+         "pri": 30,
+         "time":    10.441520,
+         "msg": "systemd[1]: systemd 254.7-1.fc39 running in system mode"
+      },{
+         "pri": 30,
+         "time":    11.441524,
+         "msg": "systemd[1]: Detected architecture x86-64."
+      },{
+         "pri": 30,
+         "time":    12.441525,
+         "msg": "systemd[1]: Running in initrd."
+      },{
+         "pri": 30,
+         "time":    13.541598,
+         "msg": "systemd[1]: Hostname set to <catalina>."
+      },{
+         "pri": 6,
+         "time":    15.641860,
+         "msg": "usb 3-3: New USB device found, idVendor=1a40, idProduct=0101, bcdDevice= 1.11"
+      },{
+         "pri": 3,
+         "time":    16.690000,
+         "msg": "Serial bus multi instantiate pseudo device driver INT3515:00: error -ENXIO: IRQ index 1 not found."
+      },{
+         "pri": 3,
+         "time":    17.710000,
+         "msg": "snd_hda_intel 0000:00:1f.3: CORB reset timeout#2, CORBRP = 65535"
+      },{
+         "pri": 46,
+         "time":    18.820000,
+         "msg": "systemd-journald[723]: Received client request to flush runtime journal."
+      },{
+         "pri": 44,
+         "time":    20.840000,
+         "msg": "systemd-journald[723]: File /var/log/journal/a124ea923b144109a12d557d5ac53179/system.journal corrupted or uncleanly shut down, renaming and replacing."
+      },{
+         "pri": 46,
+         "time":    21.852348,
+         "msg": "systemd-journald[723]: /var/log/journal/ad7a2547ac0e4342a342e62a34a3eae4/user-1000.journal: Journal file uses a different sequence number ID, rotating."
+      },{
+         "pri": 4,
+         "time":    24.871100,
+         "msg": "PEFILE: Unsigned PE binary"
+      },{
+         "pri": 3,
+         "time":    33.918091,
+         "msg": "snd_hda_intel 0000:00:1f.3: CORB reset timeout#2, CORBRP = 65535"
+      },{
+         "pri": 6,
+         "time":   144.931785,
+         "msg": "usb 3-3.1: device firmware changed"
+      },{
+         "pri": 6,
+         "time":   145.953248,
+         "msg": "usb 3-3.1: USB disconnect, device number 44"
+      },{
+         "pri": 6,
+         "time":   147.981859,
+         "msg": "usb 3-3.1: New USB device found, idVendor=17ef, idProduct=6047, bcdDevice= 3.30"
       }
    ]
 }
diff --git a/tests/ts/dmesg/cid-input b/tests/ts/dmesg/cid-input
new file mode 100644
index 000000000..7dbd89d8f
--- /dev/null
+++ b/tests/ts/dmesg/cid-input
@@ -0,0 +1,106 @@
+<0>[    0.000000] [    T0] example[0]
+<1>[    1.000000] [    T1] example[1]
+<2>[    8.000000] [    T2] example[2]
+<3>[   27.000000] [    T3] example[3]
+<4>[   64.000000] [    T4] example[4]
+<5>[  125.000000] [    T5] example[5]
+<6>[  216.000000] [    T6] example[6]
+<7>[  343.000000] [    T7] example[7]
+<8>[  512.000000] [    T8] example[8]
+<9>[  729.000000] [    T9] example[9]
+<10>[ 1000.000000] [   T10] example[10]
+<11>[ 1331.000000] [   T11] example[11]
+<12>[ 1728.000000] [   T12] example[12]
+<13>[ 2197.000000] [   T13] example[13]
+<14>[ 2744.000000] [   T14] example[14]
+<15>[ 3375.000000] [   T15] example[15]
+<16>[ 4096.000000] [   T16] example[16]
+<17>[ 4913.000000] [   T17] example[17]
+<18>[ 5832.000000] [   T18] example[18]
+<19>[ 6859.000000] [   T19] example[19]
+<20>[ 8000.000000] [   T20] example[20]
+<21>[ 9261.000000] [   T21] example[21]
+<22>[10648.000000] [   T22] example[22]
+<23>[12167.000000] [   T23] example[23]
+<24>[13824.000000] [   T24] example[24]
+<25>[15625.000000] [   T25] example[25]
+<26>[17576.000000] [   T26] example[26]
+<27>[19683.000000] [   T27] example[27]
+<28>[21952.000000] [   T28] example[28]
+<29>[24389.000000] [   T29] example[29]
+<30>[27000.000000] [   T10] example[30]
+<31>[29791.000000] [   T31] example[31]
+<32>[32768.000000] [   T32] example[32]
+<33>[35937.000000] [   T33] example[33]
+<34>[39304.000000] [   T34] example[34]
+<35>[42875.000000] [   T35] example[35]
+<36>[46656.000000] [   T36] example[36]
+<37>[50653.000000] [   T37] example[37]
+<38>[54872.000000] [   T38] example[38]
+<39>[59319.000000] [   T39] example[39]
+<40>[64000.000000] [   T40] example[40]
+<41>[68921.000000] [   T41] example[41]
+<42>[74088.000000] [   T42] example[42]
+<43>[79507.000000] [   T43] example[43]
+<44>[85184.000000] [   T44] example[44]
+<45>[91125.000000] [   T45] example[45]
+<46>[97336.000000] [   T46] example[46]
+<47>[103823.000000] [   T47] example[47]
+<48>[110592.000000] [   T48] example[48]
+<49>[117649.000000] [   T49] example[49]
+<50>[125000.000000] [   T50] example[50]
+<51>[132651.000000] [   T51] example[51]
+<52>[140608.000000] [   T52] example[52]
+<53>[148877.000000] [   T53] example[53]
+<54>[157464.000000] [   T54] example[54]
+<55>[166375.000000] [   T55] example[55]
+<56>[175616.000000] [   T56] example[56]
+<57>[185193.000000] [   T57] example[57]
+<58>[195112.000000] [   T58] example[58]
+<59>[205379.000000] [   T59] example[59]
+<60>[216000.000000] [   T60] example[60]
+<61>[226981.000000] [   T61] example[61]
+<62>[238328.000000] [   T62] example[62]
+<63>[250047.000000] [   T63] example[63]
+<64>[262144.000000] [   T64] example[64]
+<65>[274625.000000] [   T65] example[65]
+<66>[287496.000000] [   T66] example[66]
+<67>[300763.000000] [   T67] example[67]
+<68>[314432.000000] [   T68] example[68]
+<69>[328509.000000] [   T69] example[69]
+<70>[343000.000000] [   T70] example[70]
+<71>[357911.000000] [   T71] example[71]
+<72>[373248.000000] [   T72] example[72]
+<73>[389017.000000] [   T73] example[73]
+<74>[405224.000000] [   T74] example[74]
+<75>[421875.000000] [   T75] example[75]
+<76>[438976.000000] [   T76] example[76]
+<77>[456533.000000] [   T77] example[77]
+<78>[474552.000000] [   T78] example[78]
+<79>[493039.000000] [   T79] example[79]
+<80>[512000.000000] [   T80] example[80]
+<81>[531441.000000] [   T81] example[81]
+<82>[551368.000000] [   T82] example[82]
+<83>[571787.000000] [   T83] example[83]
+<84>[592704.000000] [   T84] example[84]
+<85>[614125.000000] [   T85] example[85]
+<86>[636056.000000] [   T86] example[86]
+<87>[658503.000000] [   T87] example[87]
+<88>[681472.000000] [   T88] example[88]
+<89>[704969.000000] [   T89] example[89]
+<90>[729000.000000] [   T90] example[90]
+<91>[753571.000000] [   T91] example[91]
+<92>[778688.000000] [   T92] example[92]
+<93>[804357.000000] [   T93] example[93]
+<94>[830584.000000] [   T94] example[94]
+<95>[857375.000000] [   T95] example[95]
+<96>[884736.000000] [   T96] example[96]
+<97>[912673.000000] [   T97] example[97]
+<98>[941192.000000] [   T98] example[98]
+<99>[970299.000000] [   T99] example[99]
+<100>[1000000.000000] [  T100] example[100]
+<101>[1030301.000000] [  T101] example[101]
+<102>[1061208.000000] [  T102] example[102]
+<103>[1092727.000000] [  T103] example[103]
+<104>[1124864.000000] [  T104] example[104]
+<150>[4557523.000000] [  T105] example[105]
diff --git a/tests/ts/dmesg/cid-json b/tests/ts/dmesg/cid-json
new file mode 100755
index 000000000..78363793d
--- /dev/null
+++ b/tests/ts/dmesg/cid-json
@@ -0,0 +1,28 @@
+#!/bin/bash
+
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="cid-json"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_DMESG"
+
+export TZ="GMT"
+export DMESG_TEST_BOOTIME="1234567890.123456"
+
+$TS_HELPER_DMESG -J -F $TS_SELF/cid-input >> $TS_OUTPUT 2>/dev/null
+
+ts_finalize
diff --git a/tests/ts/dmesg/cid-kmsg-colors b/tests/ts/dmesg/cid-kmsg-colors
new file mode 100755
index 000000000..90a593354
--- /dev/null
+++ b/tests/ts/dmesg/cid-kmsg-colors
@@ -0,0 +1,29 @@
+#!/bin/bash
+
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="cid-kmsg-colors"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_DMESG"
+ts_inhibit_custom_colorscheme
+
+export TZ="GMT"
+export DMESG_TEST_BOOTIME="1234567890.123456"
+
+$TS_HELPER_DMESG --color=always -K $TS_SELF/cid-kmsg-input -x >> $TS_OUTPUT 2>/dev/null
+
+ts_finalize
diff --git a/tests/ts/dmesg/cid-kmsg-console-levels b/tests/ts/dmesg/cid-kmsg-console-levels
new file mode 100755
index 000000000..2cd445d05
--- /dev/null
+++ b/tests/ts/dmesg/cid-kmsg-console-levels
@@ -0,0 +1,36 @@
+#!/bin/bash
+
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="cid-kmsg-levels"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_DMESG"
+
+export TZ="GMT"
+export DMESG_TEST_BOOTIME="1234567890.123456"
+
+for I in {-1..8}; do
+	$TS_HELPER_DMESG -K $TS_SELF/cid-kmsg-input -l $I >> $TS_OUTPUT 2>/dev/null
+done
+
+$TS_HELPER_DMESG -K $TS_SELF/cid-kmsg-input -l err+ >> $TS_OUTPUT 2>/dev/null
+$TS_HELPER_DMESG -K $TS_SELF/cid-kmsg-input -l emerg+ >> $TS_OUTPUT 2>/dev/null
+$TS_HELPER_DMESG -K $TS_SELF/cid-kmsg-input -l +err >> $TS_OUTPUT 2>/dev/null
+$TS_HELPER_DMESG -K $TS_SELF/cid-kmsg-input -l +debug >> $TS_OUTPUT 2>/dev/null
+$TS_HELPER_DMESG -K $TS_SELF/cid-kmsg-input -l + 2>> $TS_OUTPUT >/dev/null
+
+ts_finalize
diff --git a/tests/ts/dmesg/cid-kmsg-decode b/tests/ts/dmesg/cid-kmsg-decode
new file mode 100755
index 000000000..316fb2079
--- /dev/null
+++ b/tests/ts/dmesg/cid-kmsg-decode
@@ -0,0 +1,28 @@
+#!/bin/bash
+
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="cid-kmsg-decode"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_DMESG"
+
+export TZ="GMT"
+export DMESG_TEST_BOOTIME="1234567890.123456"
+
+$TS_HELPER_DMESG -x -K $TS_SELF/cid-kmsg-input >> $TS_OUTPUT 2>/dev/null
+
+ts_finalize
diff --git a/tests/ts/dmesg/cid-kmsg-delta b/tests/ts/dmesg/cid-kmsg-delta
new file mode 100755
index 000000000..64c2e6933
--- /dev/null
+++ b/tests/ts/dmesg/cid-kmsg-delta
@@ -0,0 +1,28 @@
+#!/bin/bash
+
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="cid-kmsg-delta"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_DMESG"
+
+export TZ="GMT"
+export DMESG_TEST_BOOTIME="1234567890.123456"
+
+$TS_HELPER_DMESG -d -K $TS_SELF/cid-kmsg-input >> $TS_OUTPUT 2>/dev/null
+
+ts_finalize
diff --git a/tests/ts/dmesg/cid-kmsg-facilities b/tests/ts/dmesg/cid-kmsg-facilities
new file mode 100755
index 000000000..f50f2b73d
--- /dev/null
+++ b/tests/ts/dmesg/cid-kmsg-facilities
@@ -0,0 +1,30 @@
+#!/bin/bash
+
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="cid-kmsg-facilities"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_DMESG"
+
+export TZ="GMT"
+export DMESG_TEST_BOOTIME="1234567890.123456"
+
+for I in {-1..12}; do
+	$TS_HELPER_DMESG -K $TS_SELF/cid-kmsg-input -f $I -x >> $TS_OUTPUT 2>/dev/null
+done
+
+ts_finalize
diff --git a/tests/ts/dmesg/cid-kmsg-indentation b/tests/ts/dmesg/cid-kmsg-indentation
new file mode 100755
index 000000000..d45e1e30b
--- /dev/null
+++ b/tests/ts/dmesg/cid-kmsg-indentation
@@ -0,0 +1,40 @@
+#!/bin/bash
+
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="cid-kmsg-indentation"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_DMESG"
+
+export TZ="GMT"
+export DMESG_TEST_BOOTIME="1234567890.123456"
+
+$TS_HELPER_DMESG -K $TS_SELF/cid-kmsg-newlines >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+$TS_HELPER_DMESG -K $TS_SELF/cid-kmsg-newlines >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+$TS_HELPER_DMESG --time-format=delta --kmsg-file $TS_SELF/cid-kmsg-newlines >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+$TS_HELPER_DMESG --time-format=notime --kmsg-file $TS_SELF/cid-kmsg-newlines >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+$TS_HELPER_DMESG --time-format=reltime --kmsg-file $TS_SELF/cid-kmsg-newlines >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+$TS_HELPER_DMESG --time-format=ctime --kmsg-file $TS_SELF/cid-kmsg-newlines >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+$TS_HELPER_DMESG --time-format=iso --kmsg-file $TS_SELF/cid-kmsg-newlines >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+ts_finalize
diff --git a/tests/ts/dmesg/cid-kmsg-input b/tests/ts/dmesg/cid-kmsg-input
new file mode 100644
index 0000000000000000000000000000000000000000..8ebfb5170e647b57d1f3f504150ddb3def3b4247
GIT binary patch
literal 4425
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
QJvrk#H{NA~_oc&s0T4C|J^%m!

literal 0
HcmV?d00001

diff --git a/tests/ts/dmesg/cid-kmsg-json b/tests/ts/dmesg/cid-kmsg-json
new file mode 100755
index 000000000..ad1e3e785
--- /dev/null
+++ b/tests/ts/dmesg/cid-kmsg-json
@@ -0,0 +1,28 @@
+#!/bin/bash
+
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="cid-kmsg-json"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_DMESG"
+
+export TZ="GMT"
+export DMESG_TEST_BOOTIME="1234567890.123456"
+
+$TS_HELPER_DMESG -J -K $TS_SELF/cid-kmsg-input >> $TS_OUTPUT 2>/dev/null
+
+ts_finalize
diff --git a/tests/ts/dmesg/cid-kmsg-limit b/tests/ts/dmesg/cid-kmsg-limit
new file mode 100755
index 000000000..884d4f8ce
--- /dev/null
+++ b/tests/ts/dmesg/cid-kmsg-limit
@@ -0,0 +1,29 @@
+#!/bin/bash
+
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="cid-kmsg-limit"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_DMESG"
+
+export TZ="GMT"
+export DMESG_TEST_BOOTIME="1234567890.123456"
+
+$TS_HELPER_DMESG --since @1234567890.124 --until @1234567991 -K $TS_SELF/cid-kmsg-input \
+	>> $TS_OUTPUT 2> $TS_ERRLOG
+
+ts_finalize
diff --git a/tests/ts/dmesg/cid-kmsg-newlines b/tests/ts/dmesg/cid-kmsg-newlines
new file mode 100644
index 0000000000000000000000000000000000000000..574d2177796677b73f1efcf273005169ed832c60
GIT binary patch
literal 152
zcmXrjF#tkco#e!voYW%Q5CiL+%)C^Es??%<E(Svb9YY;M128~RV`!b1TFwPh$Hia-
tQeuRm#K^j&Jf91MLCT7`7>o^cjC71K)EQfsWE7>QazV)4{GwE-1^{d2D<=Q|

literal 0
HcmV?d00001

diff --git a/tests/ts/dmesg/kmsg-input b/tests/ts/dmesg/kmsg-input
index b000f4c951ccdcec96c820d37efc64ac8b68a93c..c08331dbf2bfdc9622105e120be99e448cfa89ea 100644
GIT binary patch
literal 3944
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
CU~KgO

delta 113
zcmaDMx0s*NbRy$&Rx=$#9fOH$yMYWN9fQfXj4CW<I>tJa<Cx_pH#4dNIVKR!DMoc5
m#}vX5X3_+!h++Z>nnMH^Lj_+kX@ez=nYDnl`{n@F|I7fH$sSVx

-- 
2.43.0

