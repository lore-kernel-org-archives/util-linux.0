Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310079447
	for <util-linux@vger.kernel.org>; Sun, 31 Dec 2023 18:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="hABWznTW"
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-78158569dc6so388888385a.3
        for <util-linux@vger.kernel.org>; Sun, 31 Dec 2023 10:27:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704047273; x=1704652073;
        h=content-transfer-encoding:message-id:date:subject:cc:to:from
         :dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSc6rXJ8gQhCeuaPM35u1FZokwDVMZ9bCM/UAlKfREE=;
        b=QGBykKmsPmVA1DJrbKH02sF0nO/iSWFY7sdxf0EQwZtdin9UVW8EYihJ3EANGG91lV
         bcI64QQc4M1nvu7RG2qrFS9+gKV6Spk51EVvgQrQL0eoszVkxskUI2cAlbASyA+eNuhh
         aLcuRuqJL7b4232j+d1X/U7CtdeDkK9M5laQ0xbB2NpewMdq7ZjziBou/uHGUBj+zOWC
         ZxIFiPbFCaYoTj/umnl7bFpJN4qSAjg/4tztOvtnq1VV0K0RCuf4PT/V2usnPnNOyh+u
         yOqiqqUmzp5nv8ETeze9vUWb7IjQbrRbNtpkoDmLwDe8SwjrDBTNhQyc7omicnkpYcDW
         wPYw==
X-Gm-Message-State: AOJu0YxCHuVmRJl30xn8C5++bDU0pw355HywjIJ2bIkpxZizgLHKHDri
	YA5t5ZqHj20259AWR4Yld7ZFO1AaXNcFINbMdRRudWcnBCtfQmckfv8=
X-Google-Smtp-Source: AGHT+IH/euXN5BXa+1HY1VmVG8JVxJD2VOI7NSFre6WbHZUjSiTnWUXbuvIRyVW5Vgb6WIpXeqcY/Kcamuh2
X-Received: by 2002:a05:620a:4690:b0:781:1f1b:a02d with SMTP id bq16-20020a05620a469000b007811f1ba02dmr19601814qkb.25.1704047272841;
        Sun, 31 Dec 2023 10:27:52 -0800 (PST)
Received: from smtp.aristanetworks.com ([74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id p186-20020a815bc3000000b005e74d893964sm1769676ywb.14.2023.12.31.10.27.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Dec 2023 10:27:52 -0800 (PST)
X-Relaying-Domain: arista.com
X-SMTP-Authentication: Allow-List-permitted
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1704047271;
	bh=FSc6rXJ8gQhCeuaPM35u1FZokwDVMZ9bCM/UAlKfREE=;
	h=From:To:Cc:Subject:Date:From;
	b=hABWznTWJipLf2jsDATctUFYlikdAXMmDr3OLQZaJf203O58Dvfd2lSZY+GViDnSH
	 L8mKJFNWlmueXzJHGRkUZfa9JCYvFe40nff0H6/wtAGley061fjVXrf95yPOLDlKHd
	 oqc8wqTSHRSAFZnkmf43icIz76/BdVC5Zj6773HG3Fm8I5zRvNpKH3AyIYWNXBF4Dq
	 50TuS3rkRVDo+nnUtfdqLLvnlugXeM+ddP8FmGW9ZiTL6md3RAGRoSAkPw3TjyYAOe
	 XgTQX69Pt2pBtT+JQgM+D26tWpInHxs1l3JGzMbCyrbtRP2AdY0n2fM25TR2iHeVU4
	 M3a2h2H3T7bhg==
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Received: from us113.sjc.aristanetworks.com (us113.sjc.aristanetworks.com [10.242.240.8])
	by smtp.aristanetworks.com (Postfix) with ESMTP id DF12D400F82;
	Sun, 31 Dec 2023 10:27:51 -0800 (PST)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Received: by us113.sjc.aristanetworks.com (Postfix, from userid 10383)
	id D146CB84091E; Sun, 31 Dec 2023 10:27:51 -0800 (PST)
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
Subject: [PATCH] util-linux/sys-utils dmesg add PRINTK_CALLER support
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Date: Sun, 31 Dec 2023 10:27:49 -0800
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Message-ID: <20231231182749.2282-1-echron@arista.com>
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
                           Include expected results for new tests

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
 include/pathnames.h                          |   3 +
 sys-utils/dmesg.c                            | 128 ++++-
 tests/expected/dmesg/cid-json                | 535 +++++++++++++++++++
 tests/expected/dmesg/cid-kmsg-colors         |  45 ++
 tests/expected/dmesg/cid-kmsg-console-levels |  97 ++++
 tests/expected/dmesg/cid-kmsg-decode         |  45 ++
 tests/expected/dmesg/cid-kmsg-delta          |  45 ++
 tests/expected/dmesg/cid-kmsg-facilities     |  45 ++
 tests/expected/dmesg/cid-kmsg-indentation    |  28 +
 tests/expected/dmesg/cid-kmsg-json           | 230 ++++++++
 tests/expected/dmesg/cid-kmsg-limit          |  31 ++
 tests/expected/dmesg/kmsg-file               | 126 ++++-
 tests/ts/dmesg/cid-input                     | 106 ++++
 tests/ts/dmesg/cid-json                      |  28 +
 tests/ts/dmesg/cid-kmsg-colors               |  29 +
 tests/ts/dmesg/cid-kmsg-console-levels       |  36 ++
 tests/ts/dmesg/cid-kmsg-decode               |  28 +
 tests/ts/dmesg/cid-kmsg-delta                |  28 +
 tests/ts/dmesg/cid-kmsg-facilities           |  30 ++
 tests/ts/dmesg/cid-kmsg-indentation          |  40 ++
 tests/ts/dmesg/cid-kmsg-input                | Bin 0 -> 4425 bytes
 tests/ts/dmesg/cid-kmsg-json                 |  28 +
 tests/ts/dmesg/cid-kmsg-limit                |  29 +
 tests/ts/dmesg/cid-kmsg-newlines             | Bin 0 -> 152 bytes
 tests/ts/dmesg/kmsg-input                    | Bin 1955 -> 3944 bytes
 25 files changed, 1720 insertions(+), 20 deletions(-)
 create mode 100644 tests/expected/dmesg/cid-json
 create mode 100644 tests/expected/dmesg/cid-kmsg-colors
 create mode 100644 tests/expected/dmesg/cid-kmsg-console-levels
 create mode 100644 tests/expected/dmesg/cid-kmsg-decode
 create mode 100644 tests/expected/dmesg/cid-kmsg-delta
 create mode 100644 tests/expected/dmesg/cid-kmsg-facilities
 create mode 100644 tests/expected/dmesg/cid-kmsg-indentation
 create mode 100644 tests/expected/dmesg/cid-kmsg-json
 create mode 100644 tests/expected/dmesg/cid-kmsg-limit
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
diff --git a/tests/expected/dmesg/cid-json b/tests/expected/dmesg/cid-json
new file mode 100644
index 000000000..8a4d0e23d
--- /dev/null
+++ b/tests/expected/dmesg/cid-json
@@ -0,0 +1,535 @@
+{
+   "dmesg": [
+      {
+         "pri": 0,
+         "time":     0.000000,
+         "caller": "T0",
+         "msg": "example[0]"
+      },{
+         "pri": 1,
+         "time":     1.000000,
+         "caller": "T1",
+         "msg": "example[1]"
+      },{
+         "pri": 2,
+         "time":     8.000000,
+         "caller": "T2",
+         "msg": "example[2]"
+      },{
+         "pri": 3,
+         "time":    27.000000,
+         "caller": "T3",
+         "msg": "example[3]"
+      },{
+         "pri": 4,
+         "time":    64.000000,
+         "caller": "T4",
+         "msg": "example[4]"
+      },{
+         "pri": 5,
+         "time":   125.000000,
+         "caller": "T5",
+         "msg": "example[5]"
+      },{
+         "pri": 6,
+         "time":   216.000000,
+         "caller": "T6",
+         "msg": "example[6]"
+      },{
+         "pri": 7,
+         "time":   343.000000,
+         "caller": "T7",
+         "msg": "example[7]"
+      },{
+         "pri": 8,
+         "time":   512.000000,
+         "caller": "T8",
+         "msg": "example[8]"
+      },{
+         "pri": 9,
+         "time":   729.000000,
+         "caller": "T9",
+         "msg": "example[9]"
+      },{
+         "pri": 10,
+         "time":  1000.000000,
+         "caller": "T10",
+         "msg": "example[10]"
+      },{
+         "pri": 11,
+         "time":  1331.000000,
+         "caller": "T11",
+         "msg": "example[11]"
+      },{
+         "pri": 12,
+         "time":  1728.000000,
+         "caller": "T12",
+         "msg": "example[12]"
+      },{
+         "pri": 13,
+         "time":  2197.000000,
+         "caller": "T13",
+         "msg": "example[13]"
+      },{
+         "pri": 14,
+         "time":  2744.000000,
+         "caller": "T14",
+         "msg": "example[14]"
+      },{
+         "pri": 15,
+         "time":  3375.000000,
+         "caller": "T15",
+         "msg": "example[15]"
+      },{
+         "pri": 16,
+         "time":  4096.000000,
+         "caller": "T16",
+         "msg": "example[16]"
+      },{
+         "pri": 17,
+         "time":  4913.000000,
+         "caller": "T17",
+         "msg": "example[17]"
+      },{
+         "pri": 18,
+         "time":  5832.000000,
+         "caller": "T18",
+         "msg": "example[18]"
+      },{
+         "pri": 19,
+         "time":  6859.000000,
+         "caller": "T19",
+         "msg": "example[19]"
+      },{
+         "pri": 20,
+         "time":  8000.000000,
+         "caller": "T20",
+         "msg": "example[20]"
+      },{
+         "pri": 21,
+         "time":  9261.000000,
+         "caller": "T21",
+         "msg": "example[21]"
+      },{
+         "pri": 22,
+         "time": 10648.000000,
+         "caller": "T22",
+         "msg": "example[22]"
+      },{
+         "pri": 23,
+         "time": 12167.000000,
+         "caller": "T23",
+         "msg": "example[23]"
+      },{
+         "pri": 24,
+         "time": 13824.000000,
+         "caller": "T24",
+         "msg": "example[24]"
+      },{
+         "pri": 25,
+         "time": 15625.000000,
+         "caller": "T25",
+         "msg": "example[25]"
+      },{
+         "pri": 26,
+         "time": 17576.000000,
+         "caller": "T26",
+         "msg": "example[26]"
+      },{
+         "pri": 27,
+         "time": 19683.000000,
+         "caller": "T27",
+         "msg": "example[27]"
+      },{
+         "pri": 28,
+         "time": 21952.000000,
+         "caller": "T28",
+         "msg": "example[28]"
+      },{
+         "pri": 29,
+         "time": 24389.000000,
+         "caller": "T29",
+         "msg": "example[29]"
+      },{
+         "pri": 30,
+         "time": 27000.000000,
+         "caller": "T10",
+         "msg": "example[30]"
+      },{
+         "pri": 31,
+         "time": 29791.000000,
+         "caller": "T31",
+         "msg": "example[31]"
+      },{
+         "pri": 32,
+         "time": 32768.000000,
+         "caller": "T32",
+         "msg": "example[32]"
+      },{
+         "pri": 33,
+         "time": 35937.000000,
+         "caller": "T33",
+         "msg": "example[33]"
+      },{
+         "pri": 34,
+         "time": 39304.000000,
+         "caller": "T34",
+         "msg": "example[34]"
+      },{
+         "pri": 35,
+         "time": 42875.000000,
+         "caller": "T35",
+         "msg": "example[35]"
+      },{
+         "pri": 36,
+         "time": 46656.000000,
+         "caller": "T36",
+         "msg": "example[36]"
+      },{
+         "pri": 37,
+         "time": 50653.000000,
+         "caller": "T37",
+         "msg": "example[37]"
+      },{
+         "pri": 38,
+         "time": 54872.000000,
+         "caller": "T38",
+         "msg": "example[38]"
+      },{
+         "pri": 39,
+         "time": 59319.000000,
+         "caller": "T39",
+         "msg": "example[39]"
+      },{
+         "pri": 40,
+         "time": 64000.000000,
+         "caller": "T40",
+         "msg": "example[40]"
+      },{
+         "pri": 41,
+         "time": 68921.000000,
+         "caller": "T41",
+         "msg": "example[41]"
+      },{
+         "pri": 42,
+         "time": 74088.000000,
+         "caller": "T42",
+         "msg": "example[42]"
+      },{
+         "pri": 43,
+         "time": 79507.000000,
+         "caller": "T43",
+         "msg": "example[43]"
+      },{
+         "pri": 44,
+         "time": 85184.000000,
+         "caller": "T44",
+         "msg": "example[44]"
+      },{
+         "pri": 45,
+         "time": 91125.000000,
+         "caller": "T45",
+         "msg": "example[45]"
+      },{
+         "pri": 46,
+         "time": 97336.000000,
+         "caller": "T46",
+         "msg": "example[46]"
+      },{
+         "pri": 47,
+         "time": 103823.000000,
+         "caller": "T47",
+         "msg": "example[47]"
+      },{
+         "pri": 48,
+         "time": 110592.000000,
+         "caller": "T48",
+         "msg": "example[48]"
+      },{
+         "pri": 49,
+         "time": 117649.000000,
+         "caller": "T49",
+         "msg": "example[49]"
+      },{
+         "pri": 50,
+         "time": 125000.000000,
+         "caller": "T50",
+         "msg": "example[50]"
+      },{
+         "pri": 51,
+         "time": 132651.000000,
+         "caller": "T51",
+         "msg": "example[51]"
+      },{
+         "pri": 52,
+         "time": 140608.000000,
+         "caller": "T52",
+         "msg": "example[52]"
+      },{
+         "pri": 53,
+         "time": 148877.000000,
+         "caller": "T53",
+         "msg": "example[53]"
+      },{
+         "pri": 54,
+         "time": 157464.000000,
+         "caller": "T54",
+         "msg": "example[54]"
+      },{
+         "pri": 55,
+         "time": 166375.000000,
+         "caller": "T55",
+         "msg": "example[55]"
+      },{
+         "pri": 56,
+         "time": 175616.000000,
+         "caller": "T56",
+         "msg": "example[56]"
+      },{
+         "pri": 57,
+         "time": 185193.000000,
+         "caller": "T57",
+         "msg": "example[57]"
+      },{
+         "pri": 58,
+         "time": 195112.000000,
+         "caller": "T58",
+         "msg": "example[58]"
+      },{
+         "pri": 59,
+         "time": 205379.000000,
+         "caller": "T59",
+         "msg": "example[59]"
+      },{
+         "pri": 60,
+         "time": 216000.000000,
+         "caller": "T60",
+         "msg": "example[60]"
+      },{
+         "pri": 61,
+         "time": 226981.000000,
+         "caller": "T61",
+         "msg": "example[61]"
+      },{
+         "pri": 62,
+         "time": 238328.000000,
+         "caller": "T62",
+         "msg": "example[62]"
+      },{
+         "pri": 63,
+         "time": 250047.000000,
+         "caller": "T63",
+         "msg": "example[63]"
+      },{
+         "pri": 64,
+         "time": 262144.000000,
+         "caller": "T64",
+         "msg": "example[64]"
+      },{
+         "pri": 65,
+         "time": 274625.000000,
+         "caller": "T65",
+         "msg": "example[65]"
+      },{
+         "pri": 66,
+         "time": 287496.000000,
+         "caller": "T66",
+         "msg": "example[66]"
+      },{
+         "pri": 67,
+         "time": 300763.000000,
+         "caller": "T67",
+         "msg": "example[67]"
+      },{
+         "pri": 68,
+         "time": 314432.000000,
+         "caller": "T68",
+         "msg": "example[68]"
+      },{
+         "pri": 69,
+         "time": 328509.000000,
+         "caller": "T69",
+         "msg": "example[69]"
+      },{
+         "pri": 70,
+         "time": 343000.000000,
+         "caller": "T70",
+         "msg": "example[70]"
+      },{
+         "pri": 71,
+         "time": 357911.000000,
+         "caller": "T71",
+         "msg": "example[71]"
+      },{
+         "pri": 72,
+         "time": 373248.000000,
+         "caller": "T72",
+         "msg": "example[72]"
+      },{
+         "pri": 73,
+         "time": 389017.000000,
+         "caller": "T73",
+         "msg": "example[73]"
+      },{
+         "pri": 74,
+         "time": 405224.000000,
+         "caller": "T74",
+         "msg": "example[74]"
+      },{
+         "pri": 75,
+         "time": 421875.000000,
+         "caller": "T75",
+         "msg": "example[75]"
+      },{
+         "pri": 76,
+         "time": 438976.000000,
+         "caller": "T76",
+         "msg": "example[76]"
+      },{
+         "pri": 77,
+         "time": 456533.000000,
+         "caller": "T77",
+         "msg": "example[77]"
+      },{
+         "pri": 78,
+         "time": 474552.000000,
+         "caller": "T78",
+         "msg": "example[78]"
+      },{
+         "pri": 79,
+         "time": 493039.000000,
+         "caller": "T79",
+         "msg": "example[79]"
+      },{
+         "pri": 80,
+         "time": 512000.000000,
+         "caller": "T80",
+         "msg": "example[80]"
+      },{
+         "pri": 81,
+         "time": 531441.000000,
+         "caller": "T81",
+         "msg": "example[81]"
+      },{
+         "pri": 82,
+         "time": 551368.000000,
+         "caller": "T82",
+         "msg": "example[82]"
+      },{
+         "pri": 83,
+         "time": 571787.000000,
+         "caller": "T83",
+         "msg": "example[83]"
+      },{
+         "pri": 84,
+         "time": 592704.000000,
+         "caller": "T84",
+         "msg": "example[84]"
+      },{
+         "pri": 85,
+         "time": 614125.000000,
+         "caller": "T85",
+         "msg": "example[85]"
+      },{
+         "pri": 86,
+         "time": 636056.000000,
+         "caller": "T86",
+         "msg": "example[86]"
+      },{
+         "pri": 87,
+         "time": 658503.000000,
+         "caller": "T87",
+         "msg": "example[87]"
+      },{
+         "pri": 88,
+         "time": 681472.000000,
+         "caller": "T88",
+         "msg": "example[88]"
+      },{
+         "pri": 89,
+         "time": 704969.000000,
+         "caller": "T89",
+         "msg": "example[89]"
+      },{
+         "pri": 90,
+         "time": 729000.000000,
+         "caller": "T90",
+         "msg": "example[90]"
+      },{
+         "pri": 91,
+         "time": 753571.000000,
+         "caller": "T91",
+         "msg": "example[91]"
+      },{
+         "pri": 92,
+         "time": 778688.000000,
+         "caller": "T92",
+         "msg": "example[92]"
+      },{
+         "pri": 93,
+         "time": 804357.000000,
+         "caller": "T93",
+         "msg": "example[93]"
+      },{
+         "pri": 94,
+         "time": 830584.000000,
+         "caller": "T94",
+         "msg": "example[94]"
+      },{
+         "pri": 95,
+         "time": 857375.000000,
+         "caller": "T95",
+         "msg": "example[95]"
+      },{
+         "pri": 96,
+         "time": 884736.000000,
+         "caller": "T96",
+         "msg": "example[96]"
+      },{
+         "pri": 97,
+         "time": 912673.000000,
+         "caller": "T97",
+         "msg": "example[97]"
+      },{
+         "pri": 98,
+         "time": 941192.000000,
+         "caller": "T98",
+         "msg": "example[98]"
+      },{
+         "pri": 99,
+         "time": 970299.000000,
+         "caller": "T99",
+         "msg": "example[99]"
+      },{
+         "pri": 100,
+         "time": 1000000.000000,
+         "caller": "T100",
+         "msg": "example[100]"
+      },{
+         "pri": 101,
+         "time": 1030301.000000,
+         "caller": "T101",
+         "msg": "example[101]"
+      },{
+         "pri": 102,
+         "time": 1061208.000000,
+         "caller": "T102",
+         "msg": "example[102]"
+      },{
+         "pri": 103,
+         "time": 1092727.000000,
+         "caller": "T103",
+         "msg": "example[103]"
+      },{
+         "pri": 104,
+         "time": 1124864.000000,
+         "caller": "T104",
+         "msg": "example[104]"
+      },{
+         "pri": 150,
+         "time": 4557523.000000,
+         "caller": "T105",
+         "msg": "example[105]"
+      }
+   ]
+}
diff --git a/tests/expected/dmesg/cid-kmsg-colors b/tests/expected/dmesg/cid-kmsg-colors
new file mode 100644
index 000000000..7d11dae33
--- /dev/null
+++ b/tests/expected/dmesg/cid-kmsg-colors
@@ -0,0 +1,45 @@
+kern  :emerg : [32m[    0.000000] [0m[      T1] Linux version 6.6.4-arch1-1 (linux@archlinux) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Mon, 04 Dec 2023 00:29:19 +0000
+kern  :alert : [32m[    0.000001] [0m[      T2] [33mCommand line: [0m[7m[31minitrd=\ucode.img initrd=\initramfs-linux.img rw cryptdevice=/dev/nvme0n1p3:system:discard root=/dev/mapper/system[0m
+kern  :crit  : [32m[    0.000002] [0m[      T3] [1m[31mBIOS-provided physical RAM map:[0m
+kern  :err   : [32m[    0.000003] [0m[      T4] [33mBIOS-e820: [0m[31m[mem 0x0000000000000000-0x000000000009efff] usable[0m
+kern  :warn  : [32m[    0.000004] [0m[      T5] [33mBIOS-e820: [0m[1m[mem 0x000000000009f000-0x00000000000bffff] reserved[0m
+kern  :notice: [32m[    0.000005] [0m[      T6] [33mBIOS-e820: [0m[mem 0x0000000000100000-0x0000000009afffff] usable
+kern  :info  : [32m[    0.000006] [0m[      T7] [33mBIOS-e820: [0m[mem 0x0000000009b00000-0x0000000009dfffff] reserved
+kern  :debug : [32m[    0.000007] [0m[      T8] [33mBIOS-e820: [0m[mem 0x0000000009e00000-0x0000000009efffff] usable
+kern  :info  : [32m[    0.000008] [0m[      T9] [33mBIOS-e820: [0m[mem 0x0000000009f00000-0x0000000009f3bfff] ACPI NVS
+kern  :info  : [32m[    0.000009] [0m[     T10] [33mBIOS-e820: [0m[mem 0x0000000009f3c000-0x000000004235ffff] usable
+kern  :info  : [32m[    0.000010] [0m[     T11] [33mBIOS-e820: [0m[mem 0x0000000042360000-0x000000004455ffff] reserved
+kern  :info  : [32m[    0.201607] [0m[     T12] [33msmp: [0mBringing up secondary CPUs ...
+kern  :info  : [32m[    0.201607] [0m[     T13] [33msmpboot: [0mx86: Booting SMP configuration:
+kern  :warn  : [32m[    0.209670] [0m[     T14] [1m  #1  #3  #5  #7[0m
+kern  :info  : [32m[    0.212630] [0m[     T15] [33msmp: [0mBrought up 1 node, 16 CPUs
+kern  :notice: [32m[    0.215936] [0m[     T16] [33maudit: [0mtype=2000 audit(1702926179.015:1): state=initialized audit_enabled=0 res=1
+kern  :info  : [32m[    0.215937] [0m[     T17] [33mthermal_sys: [0mRegistered thermal governor 'fair_share'
+kern  :warn  : [32m[    0.215966] [0m[     T18] [33mENERGY_PERF_BIAS: [0m[1mSet to 'normal', was 'performance'[0m
+kern  :info  : [32m[    0.367657] [0m[     T19] [33mACPI: [0m\_SB_.PCI0.GP19.NHI1.PWRS: New power resource
+kern  :info  : [32m[    0.368615] [0m[     T20] [33mACPI: [0m\_SB_.PCI0.GP19.XHC4.PWRS: New power resource
+kern  :info  : [32m[    0.376316] [0m[     T21] [33mACPI: [0m\_SB_.PRWL: New power resource
+kern  :info  : [32m[    0.376343] [0m[     T22] [33mACPI: [0m\_SB_.PRWB: New power resource
+kern  :info  : [32m[    0.377373] [0m[     T23] [33mACPI: [0mPCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
+kern  :info  : [32m[    0.377378] [0m[     T24] [33macpi PNP0A08:00: [0m_OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
+kern  :info  : [32m[    0.377569] [0m[     T25] [33macpi PNP0A08:00: [0m_OSC: platform does not support [SHPCHotplug AER]
+kern  :info  : [32m[    0.377933] [0m[     T26] [33macpi PNP0A08:00: [0m_OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR DPC]
+kern  :info  : [32m[    0.378458] [0m[     T27] PCI host bridge to bus 0000:00
+kern  :info  : [32m[    0.378459] [0m[     T28] [33mpci_bus 0000:00: [0mroot bus resource [io  0x0000-0x0cf7 window]
+kern  :info  : [32m[    0.378461] [0m[     T29] [33mpci_bus 0000:00: [0mroot bus resource [io  0x0d00-0xffff window]
+user  :notice: [32m[    9.398562] [0m[     T30] user network daemon initialization complete
+daemon:info  : [32m[   10.441520] [0m[     T31] [33msystemd[1]: [0msystemd 254.7-1.fc39 running in system mode
+daemon:info  : [32m[   11.441524] [0m[     T32] [33msystemd[1]: [0mDetected architecture x86-64.
+daemon:info  : [32m[   12.441525] [0m[     T33] [33msystemd[1]: [0mRunning in initrd.
+daemon:info  : [32m[   13.541598] [0m[     T34] [33msystemd[1]: [0mHostname set to <catalina>.
+kern  :info  : [32m[   15.641860] [0m[     T35] [33musb 3-3: [0mNew USB device found, idVendor=1a40, idProduct=0101, bcdDevice= 1.11
+kern  :err   : [32m[   16.690000] [0m[     T36] [33mSerial bus multi instantiate pseudo device driver INT3515:00: [0m[31merror -ENXIO: IRQ index 1 not found.[0m
+kern  :err   : [32m[   17.710000] [0m[     T37] [33msnd_hda_intel 0000:00:1f.3: [0m[31mCORB reset timeout#2, CORBRP = 65535[0m
+syslog:info  : [32m[   18.820000] [0m[     T38] [33msystemd-journald[723]: [0mReceived client request to flush runtime journal.
+syslog:warn  : [32m[   20.840000] [0m[     T39] [33msystemd-journald[723]: [0m[1mFile /var/log/journal/a124ea923b144109a12d557d5ac53179/system.journal corrupted or uncleanly shut down, renaming and replacing.[0m
+syslog:info  : [32m[   21.852348] [0m[     T40] [33msystemd-journald[723]: [0m/var/log/journal/ad7a2547ac0e4342a342e62a34a3eae4/user-1000.journal: Journal file uses a different sequence number ID, rotating.
+kern  :warn  : [32m[   24.871100] [0m[      41] [33mPEFILE: [0m[1mUnsigned PE binary[0m
+kern  :err   : [32m[   33.918091] [0m[      42] [33msnd_hda_intel 0000:00:1f.3: [0m[31mCORB reset timeout#2, CORBRP = 65535[0m
+kern  :info  : [32m[  144.931785] [0m[      C1] [33musb 3-3.1: [0mdevice firmware changed
+kern  :info  : [32m[  145.953248] [0m[      C2] [33musb 3-3.1: [0mUSB disconnect, device number 44
+kern  :info  : [32m[  147.981859] [0m[      C3] [33musb 3-3.1: [0mNew USB device found, idVendor=17ef, idProduct=6047, bcdDevice= 3.30
diff --git a/tests/expected/dmesg/cid-kmsg-console-levels b/tests/expected/dmesg/cid-kmsg-console-levels
new file mode 100644
index 000000000..59c343108
--- /dev/null
+++ b/tests/expected/dmesg/cid-kmsg-console-levels
@@ -0,0 +1,97 @@
+[    0.000000] [      T1] Linux version 6.6.4-arch1-1 (linux@archlinux) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Mon, 04 Dec 2023 00:29:19 +0000
+[    0.000001] [      T2] Command line: initrd=\ucode.img initrd=\initramfs-linux.img rw cryptdevice=/dev/nvme0n1p3:system:discard root=/dev/mapper/system
+[    0.000002] [      T3] BIOS-provided physical RAM map:
+[    0.000003] [      T4] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
+[   16.690000] [     T36] Serial bus multi instantiate pseudo device driver INT3515:00: error -ENXIO: IRQ index 1 not found.
+[   17.710000] [     T37] snd_hda_intel 0000:00:1f.3: CORB reset timeout#2, CORBRP = 65535
+[   33.918091] [      42] snd_hda_intel 0000:00:1f.3: CORB reset timeout#2, CORBRP = 65535
+[    0.000004] [      T5] BIOS-e820: [mem 0x000000000009f000-0x00000000000bffff] reserved
+[    0.209670] [     T14]   #1  #3  #5  #7
+[    0.215966] [     T18] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
+[   20.840000] [     T39] systemd-journald[723]: File /var/log/journal/a124ea923b144109a12d557d5ac53179/system.journal corrupted or uncleanly shut down, renaming and replacing.
+[   24.871100] [      41] PEFILE: Unsigned PE binary
+[    0.000005] [      T6] BIOS-e820: [mem 0x0000000000100000-0x0000000009afffff] usable
+[    0.215936] [     T16] audit: type=2000 audit(1702926179.015:1): state=initialized audit_enabled=0 res=1
+[    9.398562] [     T30] user network daemon initialization complete
+[    0.000006] [      T7] BIOS-e820: [mem 0x0000000009b00000-0x0000000009dfffff] reserved
+[    0.000008] [      T9] BIOS-e820: [mem 0x0000000009f00000-0x0000000009f3bfff] ACPI NVS
+[    0.000009] [     T10] BIOS-e820: [mem 0x0000000009f3c000-0x000000004235ffff] usable
+[    0.000010] [     T11] BIOS-e820: [mem 0x0000000042360000-0x000000004455ffff] reserved
+[    0.201607] [     T12] smp: Bringing up secondary CPUs ...
+[    0.201607] [     T13] smpboot: x86: Booting SMP configuration:
+[    0.212630] [     T15] smp: Brought up 1 node, 16 CPUs
+[    0.215937] [     T17] thermal_sys: Registered thermal governor 'fair_share'
+[    0.367657] [     T19] ACPI: \_SB_.PCI0.GP19.NHI1.PWRS: New power resource
+[    0.368615] [     T20] ACPI: \_SB_.PCI0.GP19.XHC4.PWRS: New power resource
+[    0.376316] [     T21] ACPI: \_SB_.PRWL: New power resource
+[    0.376343] [     T22] ACPI: \_SB_.PRWB: New power resource
+[    0.377373] [     T23] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
+[    0.377378] [     T24] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
+[    0.377569] [     T25] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug AER]
+[    0.377933] [     T26] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR DPC]
+[    0.378458] [     T27] PCI host bridge to bus 0000:00
+[    0.378459] [     T28] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
+[    0.378461] [     T29] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
+[   10.441520] [     T31] systemd[1]: systemd 254.7-1.fc39 running in system mode
+[   11.441524] [     T32] systemd[1]: Detected architecture x86-64.
+[   12.441525] [     T33] systemd[1]: Running in initrd.
+[   13.541598] [     T34] systemd[1]: Hostname set to <catalina>.
+[   15.641860] [     T35] usb 3-3: New USB device found, idVendor=1a40, idProduct=0101, bcdDevice= 1.11
+[   18.820000] [     T38] systemd-journald[723]: Received client request to flush runtime journal.
+[   21.852348] [     T40] systemd-journald[723]: /var/log/journal/ad7a2547ac0e4342a342e62a34a3eae4/user-1000.journal: Journal file uses a different sequence number ID, rotating.
+[  144.931785] [      C1] usb 3-3.1: device firmware changed
+[  145.953248] [      C2] usb 3-3.1: USB disconnect, device number 44
+[  147.981859] [      C3] usb 3-3.1: New USB device found, idVendor=17ef, idProduct=6047, bcdDevice= 3.30
+[    0.000007] [      T8] BIOS-e820: [mem 0x0000000009e00000-0x0000000009efffff] usable
+[    0.000000] [      T1] Linux version 6.6.4-arch1-1 (linux@archlinux) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Mon, 04 Dec 2023 00:29:19 +0000
+[    0.000001] [      T2] Command line: initrd=\ucode.img initrd=\initramfs-linux.img rw cryptdevice=/dev/nvme0n1p3:system:discard root=/dev/mapper/system
+[    0.000002] [      T3] BIOS-provided physical RAM map:
+[    0.000003] [      T4] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
+[   16.690000] [     T36] Serial bus multi instantiate pseudo device driver INT3515:00: error -ENXIO: IRQ index 1 not found.
+[   17.710000] [     T37] snd_hda_intel 0000:00:1f.3: CORB reset timeout#2, CORBRP = 65535
+[   33.918091] [      42] snd_hda_intel 0000:00:1f.3: CORB reset timeout#2, CORBRP = 65535
+[    0.000000] [      T1] Linux version 6.6.4-arch1-1 (linux@archlinux) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Mon, 04 Dec 2023 00:29:19 +0000
+[    0.000003] [      T4] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
+[    0.000004] [      T5] BIOS-e820: [mem 0x000000000009f000-0x00000000000bffff] reserved
+[    0.000005] [      T6] BIOS-e820: [mem 0x0000000000100000-0x0000000009afffff] usable
+[    0.000006] [      T7] BIOS-e820: [mem 0x0000000009b00000-0x0000000009dfffff] reserved
+[    0.000007] [      T8] BIOS-e820: [mem 0x0000000009e00000-0x0000000009efffff] usable
+[    0.000008] [      T9] BIOS-e820: [mem 0x0000000009f00000-0x0000000009f3bfff] ACPI NVS
+[    0.000009] [     T10] BIOS-e820: [mem 0x0000000009f3c000-0x000000004235ffff] usable
+[    0.000010] [     T11] BIOS-e820: [mem 0x0000000042360000-0x000000004455ffff] reserved
+[    0.201607] [     T12] smp: Bringing up secondary CPUs ...
+[    0.201607] [     T13] smpboot: x86: Booting SMP configuration:
+[    0.209670] [     T14]   #1  #3  #5  #7
+[    0.212630] [     T15] smp: Brought up 1 node, 16 CPUs
+[    0.215936] [     T16] audit: type=2000 audit(1702926179.015:1): state=initialized audit_enabled=0 res=1
+[    0.215937] [     T17] thermal_sys: Registered thermal governor 'fair_share'
+[    0.215966] [     T18] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
+[    0.367657] [     T19] ACPI: \_SB_.PCI0.GP19.NHI1.PWRS: New power resource
+[    0.368615] [     T20] ACPI: \_SB_.PCI0.GP19.XHC4.PWRS: New power resource
+[    0.376316] [     T21] ACPI: \_SB_.PRWL: New power resource
+[    0.376343] [     T22] ACPI: \_SB_.PRWB: New power resource
+[    0.377373] [     T23] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
+[    0.377378] [     T24] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
+[    0.377569] [     T25] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug AER]
+[    0.377933] [     T26] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR DPC]
+[    0.378458] [     T27] PCI host bridge to bus 0000:00
+[    0.378459] [     T28] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
+[    0.378461] [     T29] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
+[    9.398562] [     T30] user network daemon initialization complete
+[   10.441520] [     T31] systemd[1]: systemd 254.7-1.fc39 running in system mode
+[   11.441524] [     T32] systemd[1]: Detected architecture x86-64.
+[   12.441525] [     T33] systemd[1]: Running in initrd.
+[   13.541598] [     T34] systemd[1]: Hostname set to <catalina>.
+[   15.641860] [     T35] usb 3-3: New USB device found, idVendor=1a40, idProduct=0101, bcdDevice= 1.11
+[   16.690000] [     T36] Serial bus multi instantiate pseudo device driver INT3515:00: error -ENXIO: IRQ index 1 not found.
+[   17.710000] [     T37] snd_hda_intel 0000:00:1f.3: CORB reset timeout#2, CORBRP = 65535
+[   18.820000] [     T38] systemd-journald[723]: Received client request to flush runtime journal.
+[   20.840000] [     T39] systemd-journald[723]: File /var/log/journal/a124ea923b144109a12d557d5ac53179/system.journal corrupted or uncleanly shut down, renaming and replacing.
+[   21.852348] [     T40] systemd-journald[723]: /var/log/journal/ad7a2547ac0e4342a342e62a34a3eae4/user-1000.journal: Journal file uses a different sequence number ID, rotating.
+[   24.871100] [      41] PEFILE: Unsigned PE binary
+[   33.918091] [      42] snd_hda_intel 0000:00:1f.3: CORB reset timeout#2, CORBRP = 65535
+[  144.931785] [      C1] usb 3-3.1: device firmware changed
+[  145.953248] [      C2] usb 3-3.1: USB disconnect, device number 44
+[  147.981859] [      C3] usb 3-3.1: New USB device found, idVendor=17ef, idProduct=6047, bcdDevice= 3.30
+[    0.000007] [      T8] BIOS-e820: [mem 0x0000000009e00000-0x0000000009efffff] usable
+test_dmesg: unknown level '+'
diff --git a/tests/expected/dmesg/cid-kmsg-decode b/tests/expected/dmesg/cid-kmsg-decode
new file mode 100644
index 000000000..f9cdab620
--- /dev/null
+++ b/tests/expected/dmesg/cid-kmsg-decode
@@ -0,0 +1,45 @@
+kern  :emerg : [    0.000000] [      T1] Linux version 6.6.4-arch1-1 (linux@archlinux) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Mon, 04 Dec 2023 00:29:19 +0000
+kern  :alert : [    0.000001] [      T2] Command line: initrd=\ucode.img initrd=\initramfs-linux.img rw cryptdevice=/dev/nvme0n1p3:system:discard root=/dev/mapper/system
+kern  :crit  : [    0.000002] [      T3] BIOS-provided physical RAM map:
+kern  :err   : [    0.000003] [      T4] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
+kern  :warn  : [    0.000004] [      T5] BIOS-e820: [mem 0x000000000009f000-0x00000000000bffff] reserved
+kern  :notice: [    0.000005] [      T6] BIOS-e820: [mem 0x0000000000100000-0x0000000009afffff] usable
+kern  :info  : [    0.000006] [      T7] BIOS-e820: [mem 0x0000000009b00000-0x0000000009dfffff] reserved
+kern  :debug : [    0.000007] [      T8] BIOS-e820: [mem 0x0000000009e00000-0x0000000009efffff] usable
+kern  :info  : [    0.000008] [      T9] BIOS-e820: [mem 0x0000000009f00000-0x0000000009f3bfff] ACPI NVS
+kern  :info  : [    0.000009] [     T10] BIOS-e820: [mem 0x0000000009f3c000-0x000000004235ffff] usable
+kern  :info  : [    0.000010] [     T11] BIOS-e820: [mem 0x0000000042360000-0x000000004455ffff] reserved
+kern  :info  : [    0.201607] [     T12] smp: Bringing up secondary CPUs ...
+kern  :info  : [    0.201607] [     T13] smpboot: x86: Booting SMP configuration:
+kern  :warn  : [    0.209670] [     T14]   #1  #3  #5  #7
+kern  :info  : [    0.212630] [     T15] smp: Brought up 1 node, 16 CPUs
+kern  :notice: [    0.215936] [     T16] audit: type=2000 audit(1702926179.015:1): state=initialized audit_enabled=0 res=1
+kern  :info  : [    0.215937] [     T17] thermal_sys: Registered thermal governor 'fair_share'
+kern  :warn  : [    0.215966] [     T18] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
+kern  :info  : [    0.367657] [     T19] ACPI: \_SB_.PCI0.GP19.NHI1.PWRS: New power resource
+kern  :info  : [    0.368615] [     T20] ACPI: \_SB_.PCI0.GP19.XHC4.PWRS: New power resource
+kern  :info  : [    0.376316] [     T21] ACPI: \_SB_.PRWL: New power resource
+kern  :info  : [    0.376343] [     T22] ACPI: \_SB_.PRWB: New power resource
+kern  :info  : [    0.377373] [     T23] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
+kern  :info  : [    0.377378] [     T24] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
+kern  :info  : [    0.377569] [     T25] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug AER]
+kern  :info  : [    0.377933] [     T26] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR DPC]
+kern  :info  : [    0.378458] [     T27] PCI host bridge to bus 0000:00
+kern  :info  : [    0.378459] [     T28] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
+kern  :info  : [    0.378461] [     T29] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
+user  :notice: [    9.398562] [     T30] user network daemon initialization complete
+daemon:info  : [   10.441520] [     T31] systemd[1]: systemd 254.7-1.fc39 running in system mode
+daemon:info  : [   11.441524] [     T32] systemd[1]: Detected architecture x86-64.
+daemon:info  : [   12.441525] [     T33] systemd[1]: Running in initrd.
+daemon:info  : [   13.541598] [     T34] systemd[1]: Hostname set to <catalina>.
+kern  :info  : [   15.641860] [     T35] usb 3-3: New USB device found, idVendor=1a40, idProduct=0101, bcdDevice= 1.11
+kern  :err   : [   16.690000] [     T36] Serial bus multi instantiate pseudo device driver INT3515:00: error -ENXIO: IRQ index 1 not found.
+kern  :err   : [   17.710000] [     T37] snd_hda_intel 0000:00:1f.3: CORB reset timeout#2, CORBRP = 65535
+syslog:info  : [   18.820000] [     T38] systemd-journald[723]: Received client request to flush runtime journal.
+syslog:warn  : [   20.840000] [     T39] systemd-journald[723]: File /var/log/journal/a124ea923b144109a12d557d5ac53179/system.journal corrupted or uncleanly shut down, renaming and replacing.
+syslog:info  : [   21.852348] [     T40] systemd-journald[723]: /var/log/journal/ad7a2547ac0e4342a342e62a34a3eae4/user-1000.journal: Journal file uses a different sequence number ID, rotating.
+kern  :warn  : [   24.871100] [      41] PEFILE: Unsigned PE binary
+kern  :err   : [   33.918091] [      42] snd_hda_intel 0000:00:1f.3: CORB reset timeout#2, CORBRP = 65535
+kern  :info  : [  144.931785] [      C1] usb 3-3.1: device firmware changed
+kern  :info  : [  145.953248] [      C2] usb 3-3.1: USB disconnect, device number 44
+kern  :info  : [  147.981859] [      C3] usb 3-3.1: New USB device found, idVendor=17ef, idProduct=6047, bcdDevice= 3.30
diff --git a/tests/expected/dmesg/cid-kmsg-delta b/tests/expected/dmesg/cid-kmsg-delta
new file mode 100644
index 000000000..25f6fb5e2
--- /dev/null
+++ b/tests/expected/dmesg/cid-kmsg-delta
@@ -0,0 +1,45 @@
+[    0.000000 <    0.000000>] [      T1] Linux version 6.6.4-arch1-1 (linux@archlinux) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Mon, 04 Dec 2023 00:29:19 +0000
+[    0.000001 <    0.000000>] [      T2] Command line: initrd=\ucode.img initrd=\initramfs-linux.img rw cryptdevice=/dev/nvme0n1p3:system:discard root=/dev/mapper/system
+[    0.000002 <    0.000000>] [      T3] BIOS-provided physical RAM map:
+[    0.000003 <    0.000000>] [      T4] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
+[    0.000004 <    0.000000>] [      T5] BIOS-e820: [mem 0x000000000009f000-0x00000000000bffff] reserved
+[    0.000005 <    0.000000>] [      T6] BIOS-e820: [mem 0x0000000000100000-0x0000000009afffff] usable
+[    0.000006 <    0.000000>] [      T7] BIOS-e820: [mem 0x0000000009b00000-0x0000000009dfffff] reserved
+[    0.000007 <    0.000000>] [      T8] BIOS-e820: [mem 0x0000000009e00000-0x0000000009efffff] usable
+[    0.000008 <    0.000000>] [      T9] BIOS-e820: [mem 0x0000000009f00000-0x0000000009f3bfff] ACPI NVS
+[    0.000009 <    0.000000>] [     T10] BIOS-e820: [mem 0x0000000009f3c000-0x000000004235ffff] usable
+[    0.000010 <    0.000000>] [     T11] BIOS-e820: [mem 0x0000000042360000-0x000000004455ffff] reserved
+[    0.201607 <    0.000000>] [     T12] smp: Bringing up secondary CPUs ...
+[    0.201607 <    0.000000>] [     T13] smpboot: x86: Booting SMP configuration:
+[    0.209670 <    0.000000>] [     T14]   #1  #3  #5  #7
+[    0.212630 <    0.000000>] [     T15] smp: Brought up 1 node, 16 CPUs
+[    0.215936 <    0.000000>] [     T16] audit: type=2000 audit(1702926179.015:1): state=initialized audit_enabled=0 res=1
+[    0.215937 <    0.000000>] [     T17] thermal_sys: Registered thermal governor 'fair_share'
+[    0.215966 <    0.000000>] [     T18] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
+[    0.367657 <    0.000000>] [     T19] ACPI: \_SB_.PCI0.GP19.NHI1.PWRS: New power resource
+[    0.368615 <    0.000000>] [     T20] ACPI: \_SB_.PCI0.GP19.XHC4.PWRS: New power resource
+[    0.376316 <    0.000000>] [     T21] ACPI: \_SB_.PRWL: New power resource
+[    0.376343 <    0.000000>] [     T22] ACPI: \_SB_.PRWB: New power resource
+[    0.377373 <    0.000000>] [     T23] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
+[    0.377378 <    0.000000>] [     T24] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
+[    0.377569 <    0.000000>] [     T25] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug AER]
+[    0.377933 <    0.000000>] [     T26] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR DPC]
+[    0.378458 <    0.000000>] [     T27] PCI host bridge to bus 0000:00
+[    0.378459 <    0.000000>] [     T28] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
+[    0.378461 <    0.000000>] [     T29] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
+[    9.398562 <    9.000000>] [     T30] user network daemon initialization complete
+[   10.441520 <    1.000000>] [     T31] systemd[1]: systemd 254.7-1.fc39 running in system mode
+[   11.441524 <    1.000000>] [     T32] systemd[1]: Detected architecture x86-64.
+[   12.441525 <    1.000000>] [     T33] systemd[1]: Running in initrd.
+[   13.541598 <    1.000000>] [     T34] systemd[1]: Hostname set to <catalina>.
+[   15.641860 <    2.000000>] [     T35] usb 3-3: New USB device found, idVendor=1a40, idProduct=0101, bcdDevice= 1.11
+[   16.690000 <    1.000000>] [     T36] Serial bus multi instantiate pseudo device driver INT3515:00: error -ENXIO: IRQ index 1 not found.
+[   17.710000 <    1.000000>] [     T37] snd_hda_intel 0000:00:1f.3: CORB reset timeout#2, CORBRP = 65535
+[   18.820000 <    1.000000>] [     T38] systemd-journald[723]: Received client request to flush runtime journal.
+[   20.840000 <    2.000000>] [     T39] systemd-journald[723]: File /var/log/journal/a124ea923b144109a12d557d5ac53179/system.journal corrupted or uncleanly shut down, renaming and replacing.
+[   21.852348 <    1.000000>] [     T40] systemd-journald[723]: /var/log/journal/ad7a2547ac0e4342a342e62a34a3eae4/user-1000.journal: Journal file uses a different sequence number ID, rotating.
+[   24.871100 <    3.000000>] [      41] PEFILE: Unsigned PE binary
+[   33.918091 <    9.000000>] [      42] snd_hda_intel 0000:00:1f.3: CORB reset timeout#2, CORBRP = 65535
+[  144.931785 <  111.000000>] [      C1] usb 3-3.1: device firmware changed
+[  145.953248 <    1.000000>] [      C2] usb 3-3.1: USB disconnect, device number 44
+[  147.981859 <    2.000000>] [      C3] usb 3-3.1: New USB device found, idVendor=17ef, idProduct=6047, bcdDevice= 3.30
diff --git a/tests/expected/dmesg/cid-kmsg-facilities b/tests/expected/dmesg/cid-kmsg-facilities
new file mode 100644
index 000000000..118bd2449
--- /dev/null
+++ b/tests/expected/dmesg/cid-kmsg-facilities
@@ -0,0 +1,45 @@
+kern  :emerg : [    0.000000] [      T1] Linux version 6.6.4-arch1-1 (linux@archlinux) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Mon, 04 Dec 2023 00:29:19 +0000
+kern  :alert : [    0.000001] [      T2] Command line: initrd=\ucode.img initrd=\initramfs-linux.img rw cryptdevice=/dev/nvme0n1p3:system:discard root=/dev/mapper/system
+kern  :crit  : [    0.000002] [      T3] BIOS-provided physical RAM map:
+kern  :err   : [    0.000003] [      T4] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
+kern  :warn  : [    0.000004] [      T5] BIOS-e820: [mem 0x000000000009f000-0x00000000000bffff] reserved
+kern  :notice: [    0.000005] [      T6] BIOS-e820: [mem 0x0000000000100000-0x0000000009afffff] usable
+kern  :info  : [    0.000006] [      T7] BIOS-e820: [mem 0x0000000009b00000-0x0000000009dfffff] reserved
+kern  :debug : [    0.000007] [      T8] BIOS-e820: [mem 0x0000000009e00000-0x0000000009efffff] usable
+kern  :info  : [    0.000008] [      T9] BIOS-e820: [mem 0x0000000009f00000-0x0000000009f3bfff] ACPI NVS
+kern  :info  : [    0.000009] [     T10] BIOS-e820: [mem 0x0000000009f3c000-0x000000004235ffff] usable
+kern  :info  : [    0.000010] [     T11] BIOS-e820: [mem 0x0000000042360000-0x000000004455ffff] reserved
+kern  :info  : [    0.201607] [     T12] smp: Bringing up secondary CPUs ...
+kern  :info  : [    0.201607] [     T13] smpboot: x86: Booting SMP configuration:
+kern  :warn  : [    0.209670] [     T14]   #1  #3  #5  #7
+kern  :info  : [    0.212630] [     T15] smp: Brought up 1 node, 16 CPUs
+kern  :notice: [    0.215936] [     T16] audit: type=2000 audit(1702926179.015:1): state=initialized audit_enabled=0 res=1
+kern  :info  : [    0.215937] [     T17] thermal_sys: Registered thermal governor 'fair_share'
+kern  :warn  : [    0.215966] [     T18] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
+kern  :info  : [    0.367657] [     T19] ACPI: \_SB_.PCI0.GP19.NHI1.PWRS: New power resource
+kern  :info  : [    0.368615] [     T20] ACPI: \_SB_.PCI0.GP19.XHC4.PWRS: New power resource
+kern  :info  : [    0.376316] [     T21] ACPI: \_SB_.PRWL: New power resource
+kern  :info  : [    0.376343] [     T22] ACPI: \_SB_.PRWB: New power resource
+kern  :info  : [    0.377373] [     T23] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
+kern  :info  : [    0.377378] [     T24] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
+kern  :info  : [    0.377569] [     T25] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug AER]
+kern  :info  : [    0.377933] [     T26] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR DPC]
+kern  :info  : [    0.378458] [     T27] PCI host bridge to bus 0000:00
+kern  :info  : [    0.378459] [     T28] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
+kern  :info  : [    0.378461] [     T29] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
+kern  :info  : [   15.641860] [     T35] usb 3-3: New USB device found, idVendor=1a40, idProduct=0101, bcdDevice= 1.11
+kern  :err   : [   16.690000] [     T36] Serial bus multi instantiate pseudo device driver INT3515:00: error -ENXIO: IRQ index 1 not found.
+kern  :err   : [   17.710000] [     T37] snd_hda_intel 0000:00:1f.3: CORB reset timeout#2, CORBRP = 65535
+kern  :warn  : [   24.871100] [      41] PEFILE: Unsigned PE binary
+kern  :err   : [   33.918091] [      42] snd_hda_intel 0000:00:1f.3: CORB reset timeout#2, CORBRP = 65535
+kern  :info  : [  144.931785] [      C1] usb 3-3.1: device firmware changed
+kern  :info  : [  145.953248] [      C2] usb 3-3.1: USB disconnect, device number 44
+kern  :info  : [  147.981859] [      C3] usb 3-3.1: New USB device found, idVendor=17ef, idProduct=6047, bcdDevice= 3.30
+user  :notice: [    9.398562] [     T30] user network daemon initialization complete
+daemon:info  : [   10.441520] [     T31] systemd[1]: systemd 254.7-1.fc39 running in system mode
+daemon:info  : [   11.441524] [     T32] systemd[1]: Detected architecture x86-64.
+daemon:info  : [   12.441525] [     T33] systemd[1]: Running in initrd.
+daemon:info  : [   13.541598] [     T34] systemd[1]: Hostname set to <catalina>.
+syslog:info  : [   18.820000] [     T38] systemd-journald[723]: Received client request to flush runtime journal.
+syslog:warn  : [   20.840000] [     T39] systemd-journald[723]: File /var/log/journal/a124ea923b144109a12d557d5ac53179/system.journal corrupted or uncleanly shut down, renaming and replacing.
+syslog:info  : [   21.852348] [     T40] systemd-journald[723]: /var/log/journal/ad7a2547ac0e4342a342e62a34a3eae4/user-1000.journal: Journal file uses a different sequence number ID, rotating.
diff --git a/tests/expected/dmesg/cid-kmsg-indentation b/tests/expected/dmesg/cid-kmsg-indentation
new file mode 100644
index 000000000..fe03a0e1e
--- /dev/null
+++ b/tests/expected/dmesg/cid-kmsg-indentation
@@ -0,0 +1,28 @@
+[    0.000000] [      T0] line zero
+[    1.000000] [      T1] new
+[    2.000000] [      T2] two
+[    3.000000] [      T3] three
+[    0.000000] [      T0] line zero
+[    1.000000] [      T1] new
+[    2.000000] [      T2] two
+[    3.000000] [      T3] three
+[<    0.000000>] [      T0] line zero
+[<    0.000000>] [      T1] new
+[<    1.000000>] [      T2] two
+[<    1.000000>] [      T3] three
+[      T0] line zero
+[      T1] new
+[      T2] two
+[      T3] three
+[Feb13 23:31] [      T0] line zero
+[  +0.000000] [      T1] new
+[  +1.000000] [      T2] two
+[  +1.000000] [      T3] three
+[Fri Feb 13 23:31:30 2009] [      T0] line zero
+[Fri Feb 13 23:31:31 2009] [      T1] new
+[Fri Feb 13 23:31:32 2009] [      T2] two
+[Fri Feb 13 23:31:33 2009] [      T3] three
+2009-02-13T23:31:30,123456+00:00 [      T0] line zero
+2009-02-13T23:31:31,123456+00:00 [      T1] new
+2009-02-13T23:31:32,123456+00:00 [      T2] two
+2009-02-13T23:31:33,123456+00:00 [      T3] three
diff --git a/tests/expected/dmesg/cid-kmsg-json b/tests/expected/dmesg/cid-kmsg-json
new file mode 100644
index 000000000..578efd720
--- /dev/null
+++ b/tests/expected/dmesg/cid-kmsg-json
@@ -0,0 +1,230 @@
+{
+   "dmesg": [
+      {
+         "pri": 0,
+         "time":     0.000000,
+         "caller": "T1",
+         "msg": "Linux version 6.6.4-arch1-1 (linux@archlinux) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Mon, 04 Dec 2023 00:29:19 +0000"
+      },{
+         "pri": 1,
+         "time":     0.000001,
+         "caller": "T2",
+         "msg": "Command line: initrd=\\ucode.img initrd=\\initramfs-linux.img rw cryptdevice=/dev/nvme0n1p3:system:discard root=/dev/mapper/system"
+      },{
+         "pri": 2,
+         "time":     0.000002,
+         "caller": "T3",
+         "msg": "BIOS-provided physical RAM map:"
+      },{
+         "pri": 3,
+         "time":     0.000003,
+         "caller": "T4",
+         "msg": "BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable"
+      },{
+         "pri": 4,
+         "time":     0.000004,
+         "caller": "T5",
+         "msg": "BIOS-e820: [mem 0x000000000009f000-0x00000000000bffff] reserved"
+      },{
+         "pri": 5,
+         "time":     0.000005,
+         "caller": "T6",
+         "msg": "BIOS-e820: [mem 0x0000000000100000-0x0000000009afffff] usable"
+      },{
+         "pri": 6,
+         "time":     0.000006,
+         "caller": "T7",
+         "msg": "BIOS-e820: [mem 0x0000000009b00000-0x0000000009dfffff] reserved"
+      },{
+         "pri": 7,
+         "time":     0.000007,
+         "caller": "T8",
+         "msg": "BIOS-e820: [mem 0x0000000009e00000-0x0000000009efffff] usable"
+      },{
+         "pri": 6,
+         "time":     0.000008,
+         "caller": "T9",
+         "msg": "BIOS-e820: [mem 0x0000000009f00000-0x0000000009f3bfff] ACPI NVS"
+      },{
+         "pri": 6,
+         "time":     0.000009,
+         "caller": "T10",
+         "msg": "BIOS-e820: [mem 0x0000000009f3c000-0x000000004235ffff] usable"
+      },{
+         "pri": 6,
+         "time":     0.000010,
+         "caller": "T11",
+         "msg": "BIOS-e820: [mem 0x0000000042360000-0x000000004455ffff] reserved"
+      },{
+         "pri": 6,
+         "time":     0.201607,
+         "caller": "T12",
+         "msg": "smp: Bringing up secondary CPUs ..."
+      },{
+         "pri": 6,
+         "time":     0.201607,
+         "caller": "T13",
+         "msg": "smpboot: x86: Booting SMP configuration:"
+      },{
+         "pri": 4,
+         "time":     0.209670,
+         "caller": "T14",
+         "msg": "  #1  #3  #5  #7"
+      },{
+         "pri": 6,
+         "time":     0.212630,
+         "caller": "T15",
+         "msg": "smp: Brought up 1 node, 16 CPUs"
+      },{
+         "pri": 5,
+         "time":     0.215936,
+         "caller": "T16",
+         "msg": "audit: type=2000 audit(1702926179.015:1): state=initialized audit_enabled=0 res=1"
+      },{
+         "pri": 6,
+         "time":     0.215937,
+         "caller": "T17",
+         "msg": "thermal_sys: Registered thermal governor 'fair_share'"
+      },{
+         "pri": 4,
+         "time":     0.215966,
+         "caller": "T18",
+         "msg": "ENERGY_PERF_BIAS: Set to 'normal', was 'performance'"
+      },{
+         "pri": 6,
+         "time":     0.367657,
+         "caller": "T19",
+         "msg": "ACPI: \\_SB_.PCI0.GP19.NHI1.PWRS: New power resource"
+      },{
+         "pri": 6,
+         "time":     0.368615,
+         "caller": "T20",
+         "msg": "ACPI: \\_SB_.PCI0.GP19.XHC4.PWRS: New power resource"
+      },{
+         "pri": 6,
+         "time":     0.376316,
+         "caller": "T21",
+         "msg": "ACPI: \\_SB_.PRWL: New power resource"
+      },{
+         "pri": 6,
+         "time":     0.376343,
+         "caller": "T22",
+         "msg": "ACPI: \\_SB_.PRWB: New power resource"
+      },{
+         "pri": 6,
+         "time":     0.377373,
+         "caller": "T23",
+         "msg": "ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])"
+      },{
+         "pri": 6,
+         "time":     0.377378,
+         "caller": "T24",
+         "msg": "acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]"
+      },{
+         "pri": 6,
+         "time":     0.377569,
+         "caller": "T25",
+         "msg": "acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug AER]"
+      },{
+         "pri": 6,
+         "time":     0.377933,
+         "caller": "T26",
+         "msg": "acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR DPC]"
+      },{
+         "pri": 6,
+         "time":     0.378458,
+         "caller": "T27",
+         "msg": "PCI host bridge to bus 0000:00"
+      },{
+         "pri": 6,
+         "time":     0.378459,
+         "caller": "T28",
+         "msg": "pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]"
+      },{
+         "pri": 6,
+         "time":     0.378461,
+         "caller": "T29",
+         "msg": "pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]"
+      },{
+         "pri": 13,
+         "time":     9.398562,
+         "caller": "T30",
+         "msg": "user network daemon initialization complete"
+      },{
+         "pri": 30,
+         "time":    10.441520,
+         "caller": "T31",
+         "msg": "systemd[1]: systemd 254.7-1.fc39 running in system mode"
+      },{
+         "pri": 30,
+         "time":    11.441524,
+         "caller": "T32",
+         "msg": "systemd[1]: Detected architecture x86-64."
+      },{
+         "pri": 30,
+         "time":    12.441525,
+         "caller": "T33",
+         "msg": "systemd[1]: Running in initrd."
+      },{
+         "pri": 30,
+         "time":    13.541598,
+         "caller": "T34",
+         "msg": "systemd[1]: Hostname set to <catalina>."
+      },{
+         "pri": 6,
+         "time":    15.641860,
+         "caller": "T35",
+         "msg": "usb 3-3: New USB device found, idVendor=1a40, idProduct=0101, bcdDevice= 1.11"
+      },{
+         "pri": 3,
+         "time":    16.690000,
+         "caller": "T36",
+         "msg": "Serial bus multi instantiate pseudo device driver INT3515:00: error -ENXIO: IRQ index 1 not found."
+      },{
+         "pri": 3,
+         "time":    17.710000,
+         "caller": "T37",
+         "msg": "snd_hda_intel 0000:00:1f.3: CORB reset timeout#2, CORBRP = 65535"
+      },{
+         "pri": 46,
+         "time":    18.820000,
+         "caller": "T38",
+         "msg": "systemd-journald[723]: Received client request to flush runtime journal."
+      },{
+         "pri": 44,
+         "time":    20.840000,
+         "caller": "T39",
+         "msg": "systemd-journald[723]: File /var/log/journal/a124ea923b144109a12d557d5ac53179/system.journal corrupted or uncleanly shut down, renaming and replacing."
+      },{
+         "pri": 46,
+         "time":    21.852348,
+         "caller": "T40",
+         "msg": "systemd-journald[723]: /var/log/journal/ad7a2547ac0e4342a342e62a34a3eae4/user-1000.journal: Journal file uses a different sequence number ID, rotating."
+      },{
+         "pri": 4,
+         "time":    24.871100,
+         "caller": "41",
+         "msg": "PEFILE: Unsigned PE binary"
+      },{
+         "pri": 3,
+         "time":    33.918091,
+         "caller": "42",
+         "msg": "snd_hda_intel 0000:00:1f.3: CORB reset timeout#2, CORBRP = 65535"
+      },{
+         "pri": 6,
+         "time":   144.931785,
+         "caller": "C1",
+         "msg": "usb 3-3.1: device firmware changed"
+      },{
+         "pri": 6,
+         "time":   145.953248,
+         "caller": "C2",
+         "msg": "usb 3-3.1: USB disconnect, device number 44"
+      },{
+         "pri": 6,
+         "time":   147.981859,
+         "caller": "C3",
+         "msg": "usb 3-3.1: New USB device found, idVendor=17ef, idProduct=6047, bcdDevice= 3.30"
+      }
+   ]
+}
diff --git a/tests/expected/dmesg/cid-kmsg-limit b/tests/expected/dmesg/cid-kmsg-limit
new file mode 100644
index 000000000..8db1c9a65
--- /dev/null
+++ b/tests/expected/dmesg/cid-kmsg-limit
@@ -0,0 +1,31 @@
+[    0.201607] [     T12] smp: Bringing up secondary CPUs ...
+[    0.201607] [     T13] smpboot: x86: Booting SMP configuration:
+[    0.209670] [     T14]   #1  #3  #5  #7
+[    0.212630] [     T15] smp: Brought up 1 node, 16 CPUs
+[    0.215936] [     T16] audit: type=2000 audit(1702926179.015:1): state=initialized audit_enabled=0 res=1
+[    0.215937] [     T17] thermal_sys: Registered thermal governor 'fair_share'
+[    0.215966] [     T18] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
+[    0.367657] [     T19] ACPI: \_SB_.PCI0.GP19.NHI1.PWRS: New power resource
+[    0.368615] [     T20] ACPI: \_SB_.PCI0.GP19.XHC4.PWRS: New power resource
+[    0.376316] [     T21] ACPI: \_SB_.PRWL: New power resource
+[    0.376343] [     T22] ACPI: \_SB_.PRWB: New power resource
+[    0.377373] [     T23] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
+[    0.377378] [     T24] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
+[    0.377569] [     T25] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug AER]
+[    0.377933] [     T26] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR DPC]
+[    0.378458] [     T27] PCI host bridge to bus 0000:00
+[    0.378459] [     T28] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
+[    0.378461] [     T29] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
+[    9.398562] [     T30] user network daemon initialization complete
+[   10.441520] [     T31] systemd[1]: systemd 254.7-1.fc39 running in system mode
+[   11.441524] [     T32] systemd[1]: Detected architecture x86-64.
+[   12.441525] [     T33] systemd[1]: Running in initrd.
+[   13.541598] [     T34] systemd[1]: Hostname set to <catalina>.
+[   15.641860] [     T35] usb 3-3: New USB device found, idVendor=1a40, idProduct=0101, bcdDevice= 1.11
+[   16.690000] [     T36] Serial bus multi instantiate pseudo device driver INT3515:00: error -ENXIO: IRQ index 1 not found.
+[   17.710000] [     T37] snd_hda_intel 0000:00:1f.3: CORB reset timeout#2, CORBRP = 65535
+[   18.820000] [     T38] systemd-journald[723]: Received client request to flush runtime journal.
+[   20.840000] [     T39] systemd-journald[723]: File /var/log/journal/a124ea923b144109a12d557d5ac53179/system.journal corrupted or uncleanly shut down, renaming and replacing.
+[   21.852348] [     T40] systemd-journald[723]: /var/log/journal/ad7a2547ac0e4342a342e62a34a3eae4/user-1000.journal: Journal file uses a different sequence number ID, rotating.
+[   24.871100] [      41] PEFILE: Unsigned PE binary
+[   33.918091] [      42] snd_hda_intel 0000:00:1f.3: CORB reset timeout#2, CORBRP = 65535
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

