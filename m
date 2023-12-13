Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="v9XwiWni"
Received: from mail-il1-x161.google.com (mail-il1-x161.google.com [IPv6:2607:f8b0:4864:20::161])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD66F4
	for <util-linux@vger.kernel.org>; Tue, 12 Dec 2023 16:09:41 -0800 (PST)
Received: by mail-il1-x161.google.com with SMTP id e9e14a558f8ab-35d3b220b64so24824205ab.2
        for <util-linux@vger.kernel.org>; Tue, 12 Dec 2023 16:09:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702426180; x=1703030980;
        h=content-transfer-encoding:message-id:date:subject:cc:to:from
         :dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lhYsr8/AlUS3RzYgXRcb4okf1Q4Gn+mU3HWoM4UIvc=;
        b=Dj/44nKF5REKqKuiNKIqDc4q3tcydBmXX/LkrUA3wVtDXBXsRrzcbu+NQqBHFhBadz
         mqp4gKuMbGt+pqTB1iJI5QW4M9+lbhTCQ55qWui9lMBEwxoomBqMaT5akh6IAF7u+m6i
         +lZ7R3PheJ7HhXPYUm76Fj2RBsaaxJiVJEe+wfb+skV6kdvOEzifQagq8yMbTrsmtsak
         4I4eY7SvYfOUiOfu+MjPd2fQe0tkN88/7kL0fZ1ylxG0MqN22CWv0tNbWgi2Mp6xcgg/
         cIaiHUCxGYqgbggSCkYR22//OiMSWYXCbcr1SZn1MgPLFG8AmF3OYwJNs9/hOfpFadJB
         nQgA==
X-Gm-Message-State: AOJu0Ywxwymev4qSh0Ag1pUlKozf0MEtmVzBFhc7mv7y1OodrrOmkzfu
	S7G4HUhH54TlMmD0BoashUvZEdn8/TVAwEjV7G1tzi3BgfphxHuO2lA6
X-Google-Smtp-Source: AGHT+IHNr9TsCIF1vM5Z2XcACvjy1lJhN0sSSb+Go5H06oqwUq6eVNY02pwRzu+XE3yfh1cGsfNu4cmrUB9U
X-Received: by 2002:a05:6e02:1c07:b0:35d:4da5:dab5 with SMTP id l7-20020a056e021c0700b0035d4da5dab5mr7773440ilh.14.1702426180302;
        Tue, 12 Dec 2023 16:09:40 -0800 (PST)
Received: from smtp.aristanetworks.com ([74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id n8-20020a056e0208e800b0035d68bb0d61sm969417ilt.21.2023.12.12.16.09.40
        for <util-linux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Dec 2023 16:09:40 -0800 (PST)
X-Relaying-Domain: arista.com
Received: from us113.sjc.aristanetworks.com (us113.sjc.aristanetworks.com [10.242.240.8])
	by smtp.aristanetworks.com (Postfix) with ESMTP id 780B5402056;
	Tue, 12 Dec 2023 16:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1702426179;
	bh=2lhYsr8/AlUS3RzYgXRcb4okf1Q4Gn+mU3HWoM4UIvc=;
	h=From:To:Cc:Subject:Date:From;
	b=v9XwiWnitWLl9TBBIuhwJ+uph7WUBT469vtIoWXmvifOcgPF4EyBMdK3aHZHDHs2p
	 +1ou4kBAgd8ZiaVa+h6Jz3TRiFgjGvkL9BcG1nsnzbQDo59XFq7ZshsmFadxse0MlE
	 HMAFD3hhRehd6KYjSRYDv2tdpig9QlWGghczLgCS7KAgdOej6aFhuyRuZPMmz2tcPb
	 yU4d15fRd1Bu28SO94rCye37MvzSt85zLd/X+6+MRkl/xgq0FjrNLPa2Lkh15AHj5w
	 k3Q4x0TFwa2/WrW0m2YF86GBrifa2C8uDe4mEwljEm3jlZ1vplLPsfj2QgC+T2BUxO
	 TQbSG0+txIKjA==
Received: by us113.sjc.aristanetworks.com (Postfix, from userid 10383)
	id 6A64CB840938; Tue, 12 Dec 2023 16:09:39 -0800 (PST)
From: Edward Chron <echron@arista.com>
To: util-linux@vger.kernel.org
Cc: colona@arista.com,
	echron@arista.com
Subject: [PATCH] util-linux/sys-utils dmesg add PRINTK_CALLER support
Date: Tue, 12 Dec 2023 16:09:37 -0800
Message-ID: <20231213000937.13560-1-echron@arista.com>
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
                           Add caller_id_size init to dmesg -K and
                           Add support for required dmesg tests

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

Signed-off-by: Ivan Delalande <colona@arista.com>
Signed-off-by: Edward Chron <echron@arista.com>
---
 include/pathnames.h                           |   3 +
 sys-utils/dmesg.c                             | 114 +++-
 .../expected/dmesg/colors-kmsg-printk-caller  |  22 +
 .../dmesg/console-levels-kmsg-printk-caller   |  45 ++
 .../expected/dmesg/decode-kmsg-printk-caller  |  22 +
 tests/expected/dmesg/delta-kmsg-printk-caller |  22 +
 .../dmesg/facilities-kmsg-printk-caller       |  22 +
 .../dmesg/indentation-kmsg-printk-caller      |  28 +
 tests/expected/dmesg/json-kmsg-printk-caller  | 115 ++++
 .../expected/dmesg/json-syslog-printk-caller  | 530 ++++++++++++++++++
 tests/expected/dmesg/kmsg-file-printk-caller  | 115 ++++
 tests/expected/dmesg/limit-kmsg-printk-caller |  11 +
 tests/ts/dmesg/colors-kmsg-printk-caller      |  29 +
 .../dmesg/console-levels-kmsg-printk-caller   |  36 ++
 tests/ts/dmesg/decode-kmsg-printk-caller      |  28 +
 tests/ts/dmesg/delta-kmsg-printk-caller       |  28 +
 tests/ts/dmesg/facilities-kmsg-printk-caller  |  30 +
 tests/ts/dmesg/indentation-kmsg-printk-caller |  40 ++
 tests/ts/dmesg/input-syslog-printk-caller     | 105 ++++
 tests/ts/dmesg/json-kmsg-printk-caller        |  28 +
 tests/ts/dmesg/json-syslog-printk-caller      |  28 +
 tests/ts/dmesg/kmsg-file-printk-caller        |  28 +
 tests/ts/dmesg/kmsg-input-printk-caller       | Bin 0 -> 2187 bytes
 tests/ts/dmesg/limit-kmsg-printk-caller       |  29 +
 tests/ts/dmesg/newlines-kmsg-printk-caller    | Bin 0 -> 152 bytes
 25 files changed, 1457 insertions(+), 1 deletion(-)
 create mode 100644 tests/expected/dmesg/colors-kmsg-printk-caller
 create mode 100644 tests/expected/dmesg/console-levels-kmsg-printk-caller
 create mode 100644 tests/expected/dmesg/decode-kmsg-printk-caller
 create mode 100644 tests/expected/dmesg/delta-kmsg-printk-caller
 create mode 100644 tests/expected/dmesg/facilities-kmsg-printk-caller
 create mode 100644 tests/expected/dmesg/indentation-kmsg-printk-caller
 create mode 100644 tests/expected/dmesg/json-kmsg-printk-caller
 create mode 100644 tests/expected/dmesg/json-syslog-printk-caller
 create mode 100644 tests/expected/dmesg/kmsg-file-printk-caller
 create mode 100644 tests/expected/dmesg/limit-kmsg-printk-caller
 create mode 100755 tests/ts/dmesg/colors-kmsg-printk-caller
 create mode 100755 tests/ts/dmesg/console-levels-kmsg-printk-caller
 create mode 100755 tests/ts/dmesg/decode-kmsg-printk-caller
 create mode 100755 tests/ts/dmesg/delta-kmsg-printk-caller
 create mode 100755 tests/ts/dmesg/facilities-kmsg-printk-caller
 create mode 100755 tests/ts/dmesg/indentation-kmsg-printk-caller
 create mode 100644 tests/ts/dmesg/input-syslog-printk-caller
 create mode 100755 tests/ts/dmesg/json-kmsg-printk-caller
 create mode 100755 tests/ts/dmesg/json-syslog-printk-caller
 create mode 100755 tests/ts/dmesg/kmsg-file-printk-caller
 create mode 100644 tests/ts/dmesg/kmsg-input-printk-caller
 create mode 100755 tests/ts/dmesg/limit-kmsg-printk-caller
 create mode 100644 tests/ts/dmesg/newlines-kmsg-printk-caller

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
index 77728b419..5a04af3e6 100644
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
@@ -65,6 +68,11 @@
 /* Return size of the log buffer */
 #define SYSLOG_ACTION_SIZE_BUFFER   10
 
+#define PID_CHARS_MAX sizeof(stringify_value(LONG_MAX))
+#define PID_CHARS_DEFAULT sizeof(stringify_value(INT_MAX))
+#define DMESG_CALLER_PREFIX "caller="
+#define DMESG_CALLER_PREFIXSZ (sizeof(DMESG_CALLER_PREFIX)-1)
+
 /*
  * Color scheme
  */
@@ -233,6 +241,7 @@ struct dmesg_control {
 			force_prefix:1;	/* force timestamp and decode prefix
 					   on each line */
 	int		indent;		/* due to timestamps if newline */
+	size_t          caller_id_size;   /* PRINTK_CALLERID max field size */
 };
 
 struct dmesg_record {
@@ -242,6 +251,7 @@ struct dmesg_record {
 	int		level;
 	int		facility;
 	struct timeval  tv;
+	char		caller_id[PID_CHARS_MAX];
 
 	const char	*next;		/* buffer with next unparsed record */
 	size_t		next_size;	/* size of the next buffer */
@@ -254,6 +264,7 @@ struct dmesg_record {
 		(_r)->level = -1; \
 		(_r)->tv.tv_sec = 0; \
 		(_r)->tv.tv_usec = 0; \
+		(_r)->caller_id[0] = 0; \
 	} while (0)
 
 static int process_kmsg(struct dmesg_control *ctl);
@@ -551,6 +562,45 @@ static int get_syslog_buffer_size(void)
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
@@ -728,6 +778,36 @@ static const char *skip_item(const char *begin, const char *end, const char *sep
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
+	char *p_cid;
+
+	p_cid = strstr(p_str, DMESG_CALLER_PREFIX);
+	if (p_cid != NULL && p_drec != NULL) {
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
@@ -795,6 +875,18 @@ static int get_next_syslog_record(struct dmesg_control *ctl,
 				begin++;
 		}
 
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
+		}
+
 		rec->mesg = begin;
 		rec->mesg_size = end - begin;
 
@@ -1101,6 +1193,19 @@ full_output:
 			color_disable();
 	}
 
+	if (*rec->caller_id) {
+		if (ctl->json) {
+			ul_jsonwrt_value_s(&ctl->jfmt, "caller", rec->caller_id);
+		} else {
+			char cidbuf[PID_CHARS_MAX+3] = {'\0'};
+
+			sprintf(cidbuf, "[%*s] ",
+				(char)ctl->caller_id_size - 1, rec->caller_id);
+			ctl->indent += strnlen(cidbuf, PID_CHARS_MAX+3);
+			fputs(cidbuf, stdout);
+		}
+	}
+
 	/*
 	 * A kernel message may contain several lines of output, separated
 	 * by '\n'.  If the timestamp and decode outputs are forced then each
@@ -1229,6 +1334,8 @@ static int init_kmsg(struct dmesg_control *ctl)
 		return -1;
 	}
 
+	ctl->caller_id_size = max_threads_id_size();
+
 	return 0;
 }
 
@@ -1284,7 +1391,10 @@ static int parse_kmsg_record(struct dmesg_control *ctl,
 		goto mesg;
 
 	/* D) optional fields (ignore) */
-	p = skip_item(p, end, ";");
+	p = skip_item(p, end, ",;");
+
+	/* Include optional PRINTK_CALLER field if it is present */
+	p = parse_callerid(p, end, rec);
 
 mesg:
 	/* E) message text */
@@ -1446,6 +1556,7 @@ int main(int argc, char *argv[])
 		.kmsg = -1,
 		.time_fmt = DMESG_TIMEFTM_TIME,
 		.indent = 0,
+		.caller_id_size = 0,
 	};
 	int colormode = UL_COLORMODE_UNDEF;
 	enum {
@@ -1542,6 +1653,7 @@ int main(int argc, char *argv[])
 		case 'K':
 			ctl.filename = optarg;
 			ctl.method = DMESG_METHOD_KMSG;
+			ctl.caller_id_size = max_threads_id_size();
 			break;
 		case 'f':
 			ctl.fltr_fac = 1;
diff --git a/tests/expected/dmesg/colors-kmsg-printk-caller b/tests/expected/dmesg/colors-kmsg-printk-caller
new file mode 100644
index 000000000..c7bf6e8b7
--- /dev/null
+++ b/tests/expected/dmesg/colors-kmsg-printk-caller
@@ -0,0 +1,22 @@
+kern  :notice: [32m[    0.000000] [0m[     T0] Linux version 6.6.4-arch1-1 (linux@archlinux) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Mon, 04 Dec 2023 00:29:19 +0000
+kern  :info  : [32m[    0.000000] [0m[     T1] [33mCommand line: [0minitrd=\ucode.img initrd=\initramfs-linux.img rw cryptdevice=/dev/nvme0n1p3:system:discard root=/dev/mapper/system
+kern  :info  : [32m[    0.000000] [0m[     T2] BIOS-provided physical RAM map:
+kern  :info  : [32m[    0.000000] [0m[     T3] [33mBIOS-e820: [0m[mem 0x0000000000000000-0x000000000009efff] usable
+kern  :info  : [32m[    0.000000] [0m[     T4] [33mBIOS-e820: [0m[mem 0x000000000009f000-0x00000000000bffff] reserved
+kern  :info  : [32m[    0.000000] [0m[     T5] [33mBIOS-e820: [0m[mem 0x0000000000100000-0x0000000009afffff] usable
+kern  :info  : [32m[    0.000000] [0m[     T6] [33mBIOS-e820: [0m[mem 0x0000000009b00000-0x0000000009dfffff] reserved
+kern  :info  : [32m[    0.000000] [0m[     T7] [33mBIOS-e820: [0m[mem 0x0000000009e00000-0x0000000009efffff] usable
+kern  :info  : [32m[    0.000000] [0m[     T8] [33mBIOS-e820: [0m[mem 0x0000000009f00000-0x0000000009f3bfff] ACPI NVS
+kern  :info  : [32m[    0.000000] [0m[     T9] [33mBIOS-e820: [0m[mem 0x0000000009f3c000-0x000000004235ffff] usable
+kern  :info  : [32m[    0.000000] [0m[    T10] [33mBIOS-e820: [0m[mem 0x0000000042360000-0x000000004455ffff] reserved
+kern  :info  : [32m[    0.367657] [0m[    T11] [33mACPI: [0m\_SB_.PCI0.GP19.NHI1.PWRS: New power resource
+kern  :info  : [32m[    0.368615] [0m[    T12] [33mACPI: [0m\_SB_.PCI0.GP19.XHC4.PWRS: New power resource
+kern  :info  : [32m[    0.376316] [0m[    T13] [33mACPI: [0m\_SB_.PRWL: New power resource
+kern  :info  : [32m[    0.376343] [0m[    T14] [33mACPI: [0m\_SB_.PRWB: New power resource
+kern  :info  : [32m[    0.377373] [0m[    T15] [33mACPI: [0mPCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
+kern  :info  : [32m[    0.377378] [0m[    T16] [33macpi PNP0A08:00: [0m_OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
+kern  :info  : [32m[    0.377569] [0m[    T17] [33macpi PNP0A08:00: [0m_OSC: platform does not support [SHPCHotplug AER]
+kern  :info  : [32m[    0.377933] [0m[    T18] [33macpi PNP0A08:00: [0m_OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR DPC]
+kern  :info  : [32m[    0.378458] [0m[    T19] PCI host bridge to bus 0000:00
+kern  :info  : [32m[    0.378459] [0m[    T20] [33mpci_bus 0000:00: [0mroot bus resource [io  0x0000-0x0cf7 window]
+kern  :info  : [32m[    0.378461] [0m[    T21] [33mpci_bus 0000:00: [0mroot bus resource [io  0x0d00-0xffff window]
diff --git a/tests/expected/dmesg/console-levels-kmsg-printk-caller b/tests/expected/dmesg/console-levels-kmsg-printk-caller
new file mode 100644
index 000000000..1f6e9f178
--- /dev/null
+++ b/tests/expected/dmesg/console-levels-kmsg-printk-caller
@@ -0,0 +1,45 @@
+[    0.000000] [     T0] Linux version 6.6.4-arch1-1 (linux@archlinux) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Mon, 04 Dec 2023 00:29:19 +0000
+[    0.000000] [     T1] Command line: initrd=\ucode.img initrd=\initramfs-linux.img rw cryptdevice=/dev/nvme0n1p3:system:discard root=/dev/mapper/system
+[    0.000000] [     T2] BIOS-provided physical RAM map:
+[    0.000000] [     T3] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
+[    0.000000] [     T4] BIOS-e820: [mem 0x000000000009f000-0x00000000000bffff] reserved
+[    0.000000] [     T5] BIOS-e820: [mem 0x0000000000100000-0x0000000009afffff] usable
+[    0.000000] [     T6] BIOS-e820: [mem 0x0000000009b00000-0x0000000009dfffff] reserved
+[    0.000000] [     T7] BIOS-e820: [mem 0x0000000009e00000-0x0000000009efffff] usable
+[    0.000000] [     T8] BIOS-e820: [mem 0x0000000009f00000-0x0000000009f3bfff] ACPI NVS
+[    0.000000] [     T9] BIOS-e820: [mem 0x0000000009f3c000-0x000000004235ffff] usable
+[    0.000000] [    T10] BIOS-e820: [mem 0x0000000042360000-0x000000004455ffff] reserved
+[    0.367657] [    T11] ACPI: \_SB_.PCI0.GP19.NHI1.PWRS: New power resource
+[    0.368615] [    T12] ACPI: \_SB_.PCI0.GP19.XHC4.PWRS: New power resource
+[    0.376316] [    T13] ACPI: \_SB_.PRWL: New power resource
+[    0.376343] [    T14] ACPI: \_SB_.PRWB: New power resource
+[    0.377373] [    T15] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
+[    0.377378] [    T16] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
+[    0.377569] [    T17] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug AER]
+[    0.377933] [    T18] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR DPC]
+[    0.378458] [    T19] PCI host bridge to bus 0000:00
+[    0.378459] [    T20] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
+[    0.378461] [    T21] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
+[    0.000000] [     T0] Linux version 6.6.4-arch1-1 (linux@archlinux) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Mon, 04 Dec 2023 00:29:19 +0000
+[    0.000000] [     T1] Command line: initrd=\ucode.img initrd=\initramfs-linux.img rw cryptdevice=/dev/nvme0n1p3:system:discard root=/dev/mapper/system
+[    0.000000] [     T2] BIOS-provided physical RAM map:
+[    0.000000] [     T3] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
+[    0.000000] [     T4] BIOS-e820: [mem 0x000000000009f000-0x00000000000bffff] reserved
+[    0.000000] [     T5] BIOS-e820: [mem 0x0000000000100000-0x0000000009afffff] usable
+[    0.000000] [     T6] BIOS-e820: [mem 0x0000000009b00000-0x0000000009dfffff] reserved
+[    0.000000] [     T7] BIOS-e820: [mem 0x0000000009e00000-0x0000000009efffff] usable
+[    0.000000] [     T8] BIOS-e820: [mem 0x0000000009f00000-0x0000000009f3bfff] ACPI NVS
+[    0.000000] [     T9] BIOS-e820: [mem 0x0000000009f3c000-0x000000004235ffff] usable
+[    0.000000] [    T10] BIOS-e820: [mem 0x0000000042360000-0x000000004455ffff] reserved
+[    0.367657] [    T11] ACPI: \_SB_.PCI0.GP19.NHI1.PWRS: New power resource
+[    0.368615] [    T12] ACPI: \_SB_.PCI0.GP19.XHC4.PWRS: New power resource
+[    0.376316] [    T13] ACPI: \_SB_.PRWL: New power resource
+[    0.376343] [    T14] ACPI: \_SB_.PRWB: New power resource
+[    0.377373] [    T15] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
+[    0.377378] [    T16] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
+[    0.377569] [    T17] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug AER]
+[    0.377933] [    T18] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR DPC]
+[    0.378458] [    T19] PCI host bridge to bus 0000:00
+[    0.378459] [    T20] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
+[    0.378461] [    T21] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
+test_dmesg: unknown level '+'
diff --git a/tests/expected/dmesg/decode-kmsg-printk-caller b/tests/expected/dmesg/decode-kmsg-printk-caller
new file mode 100644
index 000000000..78c363389
--- /dev/null
+++ b/tests/expected/dmesg/decode-kmsg-printk-caller
@@ -0,0 +1,22 @@
+kern  :notice: [    0.000000] [     T0] Linux version 6.6.4-arch1-1 (linux@archlinux) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Mon, 04 Dec 2023 00:29:19 +0000
+kern  :info  : [    0.000000] [     T1] Command line: initrd=\ucode.img initrd=\initramfs-linux.img rw cryptdevice=/dev/nvme0n1p3:system:discard root=/dev/mapper/system
+kern  :info  : [    0.000000] [     T2] BIOS-provided physical RAM map:
+kern  :info  : [    0.000000] [     T3] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
+kern  :info  : [    0.000000] [     T4] BIOS-e820: [mem 0x000000000009f000-0x00000000000bffff] reserved
+kern  :info  : [    0.000000] [     T5] BIOS-e820: [mem 0x0000000000100000-0x0000000009afffff] usable
+kern  :info  : [    0.000000] [     T6] BIOS-e820: [mem 0x0000000009b00000-0x0000000009dfffff] reserved
+kern  :info  : [    0.000000] [     T7] BIOS-e820: [mem 0x0000000009e00000-0x0000000009efffff] usable
+kern  :info  : [    0.000000] [     T8] BIOS-e820: [mem 0x0000000009f00000-0x0000000009f3bfff] ACPI NVS
+kern  :info  : [    0.000000] [     T9] BIOS-e820: [mem 0x0000000009f3c000-0x000000004235ffff] usable
+kern  :info  : [    0.000000] [    T10] BIOS-e820: [mem 0x0000000042360000-0x000000004455ffff] reserved
+kern  :info  : [    0.367657] [    T11] ACPI: \_SB_.PCI0.GP19.NHI1.PWRS: New power resource
+kern  :info  : [    0.368615] [    T12] ACPI: \_SB_.PCI0.GP19.XHC4.PWRS: New power resource
+kern  :info  : [    0.376316] [    T13] ACPI: \_SB_.PRWL: New power resource
+kern  :info  : [    0.376343] [    T14] ACPI: \_SB_.PRWB: New power resource
+kern  :info  : [    0.377373] [    T15] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
+kern  :info  : [    0.377378] [    T16] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
+kern  :info  : [    0.377569] [    T17] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug AER]
+kern  :info  : [    0.377933] [    T18] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR DPC]
+kern  :info  : [    0.378458] [    T19] PCI host bridge to bus 0000:00
+kern  :info  : [    0.378459] [    T20] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
+kern  :info  : [    0.378461] [    T21] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
diff --git a/tests/expected/dmesg/delta-kmsg-printk-caller b/tests/expected/dmesg/delta-kmsg-printk-caller
new file mode 100644
index 000000000..892d2dcea
--- /dev/null
+++ b/tests/expected/dmesg/delta-kmsg-printk-caller
@@ -0,0 +1,22 @@
+[    0.000000 <    0.000000>] [     T0] Linux version 6.6.4-arch1-1 (linux@archlinux) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Mon, 04 Dec 2023 00:29:19 +0000
+[    0.000000 <    0.000000>] [     T1] Command line: initrd=\ucode.img initrd=\initramfs-linux.img rw cryptdevice=/dev/nvme0n1p3:system:discard root=/dev/mapper/system
+[    0.000000 <    0.000000>] [     T2] BIOS-provided physical RAM map:
+[    0.000000 <    0.000000>] [     T3] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
+[    0.000000 <    0.000000>] [     T4] BIOS-e820: [mem 0x000000000009f000-0x00000000000bffff] reserved
+[    0.000000 <    0.000000>] [     T5] BIOS-e820: [mem 0x0000000000100000-0x0000000009afffff] usable
+[    0.000000 <    0.000000>] [     T6] BIOS-e820: [mem 0x0000000009b00000-0x0000000009dfffff] reserved
+[    0.000000 <    0.000000>] [     T7] BIOS-e820: [mem 0x0000000009e00000-0x0000000009efffff] usable
+[    0.000000 <    0.000000>] [     T8] BIOS-e820: [mem 0x0000000009f00000-0x0000000009f3bfff] ACPI NVS
+[    0.000000 <    0.000000>] [     T9] BIOS-e820: [mem 0x0000000009f3c000-0x000000004235ffff] usable
+[    0.000000 <    0.000000>] [    T10] BIOS-e820: [mem 0x0000000042360000-0x000000004455ffff] reserved
+[    0.367657 <    0.000000>] [    T11] ACPI: \_SB_.PCI0.GP19.NHI1.PWRS: New power resource
+[    0.368615 <    0.000000>] [    T12] ACPI: \_SB_.PCI0.GP19.XHC4.PWRS: New power resource
+[    0.376316 <    0.000000>] [    T13] ACPI: \_SB_.PRWL: New power resource
+[    0.376343 <    0.000000>] [    T14] ACPI: \_SB_.PRWB: New power resource
+[    0.377373 <    0.000000>] [    T15] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
+[    0.377378 <    0.000000>] [    T16] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
+[    0.377569 <    0.000000>] [    T17] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug AER]
+[    0.377933 <    0.000000>] [    T18] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR DPC]
+[    0.378458 <    0.000000>] [    T19] PCI host bridge to bus 0000:00
+[    0.378459 <    0.000000>] [    T20] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
+[    0.378461 <    0.000000>] [    T21] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
diff --git a/tests/expected/dmesg/facilities-kmsg-printk-caller b/tests/expected/dmesg/facilities-kmsg-printk-caller
new file mode 100644
index 000000000..78c363389
--- /dev/null
+++ b/tests/expected/dmesg/facilities-kmsg-printk-caller
@@ -0,0 +1,22 @@
+kern  :notice: [    0.000000] [     T0] Linux version 6.6.4-arch1-1 (linux@archlinux) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Mon, 04 Dec 2023 00:29:19 +0000
+kern  :info  : [    0.000000] [     T1] Command line: initrd=\ucode.img initrd=\initramfs-linux.img rw cryptdevice=/dev/nvme0n1p3:system:discard root=/dev/mapper/system
+kern  :info  : [    0.000000] [     T2] BIOS-provided physical RAM map:
+kern  :info  : [    0.000000] [     T3] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
+kern  :info  : [    0.000000] [     T4] BIOS-e820: [mem 0x000000000009f000-0x00000000000bffff] reserved
+kern  :info  : [    0.000000] [     T5] BIOS-e820: [mem 0x0000000000100000-0x0000000009afffff] usable
+kern  :info  : [    0.000000] [     T6] BIOS-e820: [mem 0x0000000009b00000-0x0000000009dfffff] reserved
+kern  :info  : [    0.000000] [     T7] BIOS-e820: [mem 0x0000000009e00000-0x0000000009efffff] usable
+kern  :info  : [    0.000000] [     T8] BIOS-e820: [mem 0x0000000009f00000-0x0000000009f3bfff] ACPI NVS
+kern  :info  : [    0.000000] [     T9] BIOS-e820: [mem 0x0000000009f3c000-0x000000004235ffff] usable
+kern  :info  : [    0.000000] [    T10] BIOS-e820: [mem 0x0000000042360000-0x000000004455ffff] reserved
+kern  :info  : [    0.367657] [    T11] ACPI: \_SB_.PCI0.GP19.NHI1.PWRS: New power resource
+kern  :info  : [    0.368615] [    T12] ACPI: \_SB_.PCI0.GP19.XHC4.PWRS: New power resource
+kern  :info  : [    0.376316] [    T13] ACPI: \_SB_.PRWL: New power resource
+kern  :info  : [    0.376343] [    T14] ACPI: \_SB_.PRWB: New power resource
+kern  :info  : [    0.377373] [    T15] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
+kern  :info  : [    0.377378] [    T16] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
+kern  :info  : [    0.377569] [    T17] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug AER]
+kern  :info  : [    0.377933] [    T18] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR DPC]
+kern  :info  : [    0.378458] [    T19] PCI host bridge to bus 0000:00
+kern  :info  : [    0.378459] [    T20] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
+kern  :info  : [    0.378461] [    T21] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
diff --git a/tests/expected/dmesg/indentation-kmsg-printk-caller b/tests/expected/dmesg/indentation-kmsg-printk-caller
new file mode 100644
index 000000000..47ad73f27
--- /dev/null
+++ b/tests/expected/dmesg/indentation-kmsg-printk-caller
@@ -0,0 +1,28 @@
+[    0.000000] [     T0] line zero
+[    1.000000] [     T1] new
+[    2.000000] [     T2] two
+[    3.000000] [     T3] three
+kern  :notice: [    0.000000] [     T0] line zero
+user  :crit  : [    1.000000] [     T1] new
+mail  :warn  : [    2.000000] [     T2] two
+daemon:info  : [    3.000000] [     T3] three
+[<    0.000000>] [     T0] line zero
+[<    0.000000>] [     T1] new
+[<    1.000000>] [     T2] two
+[<    1.000000>] [     T3] three
+[     T0] line zero
+[     T1] new
+[     T2] two
+[     T3] three
+[Feb13 23:31] [     T0] line zero
+[  +0.000000] [     T1] new
+[  +1.000000] [     T2] two
+[  +1.000000] [     T3] three
+[Fri Feb 13 23:31:30 2009] [     T0] line zero
+[Fri Feb 13 23:31:31 2009] [     T1] new
+[Fri Feb 13 23:31:32 2009] [     T2] two
+[Fri Feb 13 23:31:33 2009] [     T3] three
+2009-02-13T23:31:30,123456+00:00 [     T0] line zero
+2009-02-13T23:31:31,123456+00:00 [     T1] new
+2009-02-13T23:31:32,123456+00:00 [     T2] two
+2009-02-13T23:31:33,123456+00:00 [     T3] three
diff --git a/tests/expected/dmesg/json-kmsg-printk-caller b/tests/expected/dmesg/json-kmsg-printk-caller
new file mode 100644
index 000000000..785d730a5
--- /dev/null
+++ b/tests/expected/dmesg/json-kmsg-printk-caller
@@ -0,0 +1,115 @@
+{
+   "dmesg": [
+      {
+         "pri": 5,
+         "time":     0.000000,
+         "caller": "T0",
+         "msg": "Linux version 6.6.4-arch1-1 (linux@archlinux) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Mon, 04 Dec 2023 00:29:19 +0000"
+      },{
+         "pri": 6,
+         "time":     0.000000,
+         "caller": "T1",
+         "msg": "Command line: initrd=\\ucode.img initrd=\\initramfs-linux.img rw cryptdevice=/dev/nvme0n1p3:system:discard root=/dev/mapper/system"
+      },{
+         "pri": 6,
+         "time":     0.000000,
+         "caller": "T2",
+         "msg": "BIOS-provided physical RAM map:"
+      },{
+         "pri": 6,
+         "time":     0.000000,
+         "caller": "T3",
+         "msg": "BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable"
+      },{
+         "pri": 6,
+         "time":     0.000000,
+         "caller": "T4",
+         "msg": "BIOS-e820: [mem 0x000000000009f000-0x00000000000bffff] reserved"
+      },{
+         "pri": 6,
+         "time":     0.000000,
+         "caller": "T5",
+         "msg": "BIOS-e820: [mem 0x0000000000100000-0x0000000009afffff] usable"
+      },{
+         "pri": 6,
+         "time":     0.000000,
+         "caller": "T6",
+         "msg": "BIOS-e820: [mem 0x0000000009b00000-0x0000000009dfffff] reserved"
+      },{
+         "pri": 6,
+         "time":     0.000000,
+         "caller": "T7",
+         "msg": "BIOS-e820: [mem 0x0000000009e00000-0x0000000009efffff] usable"
+      },{
+         "pri": 6,
+         "time":     0.000000,
+         "caller": "T8",
+         "msg": "BIOS-e820: [mem 0x0000000009f00000-0x0000000009f3bfff] ACPI NVS"
+      },{
+         "pri": 6,
+         "time":     0.000000,
+         "caller": "T9",
+         "msg": "BIOS-e820: [mem 0x0000000009f3c000-0x000000004235ffff] usable"
+      },{
+         "pri": 6,
+         "time":     0.000000,
+         "caller": "T10",
+         "msg": "BIOS-e820: [mem 0x0000000042360000-0x000000004455ffff] reserved"
+      },{
+         "pri": 6,
+         "time":     0.367657,
+         "caller": "T11",
+         "msg": "ACPI: \\_SB_.PCI0.GP19.NHI1.PWRS: New power resource"
+      },{
+         "pri": 6,
+         "time":     0.368615,
+         "caller": "T12",
+         "msg": "ACPI: \\_SB_.PCI0.GP19.XHC4.PWRS: New power resource"
+      },{
+         "pri": 6,
+         "time":     0.376316,
+         "caller": "T13",
+         "msg": "ACPI: \\_SB_.PRWL: New power resource"
+      },{
+         "pri": 6,
+         "time":     0.376343,
+         "caller": "T14",
+         "msg": "ACPI: \\_SB_.PRWB: New power resource"
+      },{
+         "pri": 6,
+         "time":     0.377373,
+         "caller": "T15",
+         "msg": "ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])"
+      },{
+         "pri": 6,
+         "time":     0.377378,
+         "caller": "T16",
+         "msg": "acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]"
+      },{
+         "pri": 6,
+         "time":     0.377569,
+         "caller": "T17",
+         "msg": "acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug AER]"
+      },{
+         "pri": 6,
+         "time":     0.377933,
+         "caller": "T18",
+         "msg": "acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR DPC]"
+      },{
+         "pri": 6,
+         "time":     0.378458,
+         "caller": "T19",
+         "msg": "PCI host bridge to bus 0000:00"
+      },{
+         "pri": 6,
+         "time":     0.378459,
+         "caller": "T20",
+         "msg": "pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]"
+      },{
+         "pri": 6,
+         "time":     0.378461,
+         "caller": "T21",
+         "msg": "pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]"
+      }
+   ]
+}
diff --git a/tests/expected/dmesg/json-syslog-printk-caller b/tests/expected/dmesg/json-syslog-printk-caller
new file mode 100644
index 000000000..40c98aa67
--- /dev/null
+++ b/tests/expected/dmesg/json-syslog-printk-caller
@@ -0,0 +1,530 @@
+{
+   "dmesg": [
+      {
+         "pri": 0,
+         "time":     0.000000,
+         "caller": "T0",
+         "msg": " example[0]"
+      },{
+         "pri": 1,
+         "time":     1.000000,
+         "caller": "T1",
+         "msg": " example[1]"
+      },{
+         "pri": 2,
+         "time":     8.000000,
+         "caller": "T2",
+         "msg": " example[2]"
+      },{
+         "pri": 3,
+         "time":    27.000000,
+         "caller": "T3",
+         "msg": " example[3]"
+      },{
+         "pri": 4,
+         "time":    64.000000,
+         "caller": "T4",
+         "msg": " example[4]"
+      },{
+         "pri": 5,
+         "time":   125.000000,
+         "caller": "T5",
+         "msg": " example[5]"
+      },{
+         "pri": 6,
+         "time":   216.000000,
+         "caller": "T6",
+         "msg": " example[6]"
+      },{
+         "pri": 7,
+         "time":   343.000000,
+         "caller": "T7",
+         "msg": " example[7]"
+      },{
+         "pri": 8,
+         "time":   512.000000,
+         "caller": "T8",
+         "msg": " example[8]"
+      },{
+         "pri": 9,
+         "time":   729.000000,
+         "caller": "T9",
+         "msg": " example[9]"
+      },{
+         "pri": 10,
+         "time":  1000.000000,
+         "caller": "T10",
+         "msg": " example[10]"
+      },{
+         "pri": 11,
+         "time":  1331.000000,
+         "caller": "T11",
+         "msg": " example[11]"
+      },{
+         "pri": 12,
+         "time":  1728.000000,
+         "caller": "T12",
+         "msg": " example[12]"
+      },{
+         "pri": 13,
+         "time":  2197.000000,
+         "caller": "T13",
+         "msg": " example[13]"
+      },{
+         "pri": 14,
+         "time":  2744.000000,
+         "caller": "T14",
+         "msg": " example[14]"
+      },{
+         "pri": 15,
+         "time":  3375.000000,
+         "caller": "T15",
+         "msg": " example[15]"
+      },{
+         "pri": 16,
+         "time":  4096.000000,
+         "caller": "T16",
+         "msg": " example[16]"
+      },{
+         "pri": 17,
+         "time":  4913.000000,
+         "caller": "T17",
+         "msg": " example[17]"
+      },{
+         "pri": 18,
+         "time":  5832.000000,
+         "caller": "T18",
+         "msg": " example[18]"
+      },{
+         "pri": 19,
+         "time":  6859.000000,
+         "caller": "T19",
+         "msg": " example[19]"
+      },{
+         "pri": 20,
+         "time":  8000.000000,
+         "caller": "T20",
+         "msg": " example[20]"
+      },{
+         "pri": 21,
+         "time":  9261.000000,
+         "caller": "T21",
+         "msg": " example[21]"
+      },{
+         "pri": 22,
+         "time": 10648.000000,
+         "caller": "T22",
+         "msg": " example[22]"
+      },{
+         "pri": 23,
+         "time": 12167.000000,
+         "caller": "T23",
+         "msg": " example[23]"
+      },{
+         "pri": 24,
+         "time": 13824.000000,
+         "caller": "T24",
+         "msg": " example[24]"
+      },{
+         "pri": 25,
+         "time": 15625.000000,
+         "caller": "T25",
+         "msg": " example[25]"
+      },{
+         "pri": 26,
+         "time": 17576.000000,
+         "caller": "T26",
+         "msg": " example[26]"
+      },{
+         "pri": 27,
+         "time": 19683.000000,
+         "caller": "T27",
+         "msg": " example[27]"
+      },{
+         "pri": 28,
+         "time": 21952.000000,
+         "caller": "T28",
+         "msg": " example[28]"
+      },{
+         "pri": 29,
+         "time": 24389.000000,
+         "caller": "T29",
+         "msg": " example[29]"
+      },{
+         "pri": 30,
+         "time": 27000.000000,
+         "caller": "T10",
+         "msg": " example[30]"
+      },{
+         "pri": 31,
+         "time": 29791.000000,
+         "caller": "T31",
+         "msg": " example[31]"
+      },{
+         "pri": 32,
+         "time": 32768.000000,
+         "caller": "T32",
+         "msg": " example[32]"
+      },{
+         "pri": 33,
+         "time": 35937.000000,
+         "caller": "T33",
+         "msg": " example[33]"
+      },{
+         "pri": 34,
+         "time": 39304.000000,
+         "caller": "T34",
+         "msg": " example[34]"
+      },{
+         "pri": 35,
+         "time": 42875.000000,
+         "caller": "T35",
+         "msg": " example[35]"
+      },{
+         "pri": 36,
+         "time": 46656.000000,
+         "caller": "T36",
+         "msg": " example[36]"
+      },{
+         "pri": 37,
+         "time": 50653.000000,
+         "caller": "T37",
+         "msg": " example[37]"
+      },{
+         "pri": 38,
+         "time": 54872.000000,
+         "caller": "T38",
+         "msg": " example[38]"
+      },{
+         "pri": 39,
+         "time": 59319.000000,
+         "caller": "T39",
+         "msg": " example[39]"
+      },{
+         "pri": 40,
+         "time": 64000.000000,
+         "caller": "T40",
+         "msg": " example[40]"
+      },{
+         "pri": 41,
+         "time": 68921.000000,
+         "caller": "T41",
+         "msg": " example[41]"
+      },{
+         "pri": 42,
+         "time": 74088.000000,
+         "caller": "T42",
+         "msg": " example[42]"
+      },{
+         "pri": 43,
+         "time": 79507.000000,
+         "caller": "T43",
+         "msg": " example[43]"
+      },{
+         "pri": 44,
+         "time": 85184.000000,
+         "caller": "T44",
+         "msg": " example[44]"
+      },{
+         "pri": 45,
+         "time": 91125.000000,
+         "caller": "T45",
+         "msg": " example[45]"
+      },{
+         "pri": 46,
+         "time": 97336.000000,
+         "caller": "T46",
+         "msg": " example[46]"
+      },{
+         "pri": 47,
+         "time": 103823.000000,
+         "caller": "T47",
+         "msg": " example[47]"
+      },{
+         "pri": 48,
+         "time": 110592.000000,
+         "caller": "T48",
+         "msg": " example[48]"
+      },{
+         "pri": 49,
+         "time": 117649.000000,
+         "caller": "T49",
+         "msg": " example[49]"
+      },{
+         "pri": 50,
+         "time": 125000.000000,
+         "caller": "T50",
+         "msg": " example[50]"
+      },{
+         "pri": 51,
+         "time": 132651.000000,
+         "caller": "T51",
+         "msg": " example[51]"
+      },{
+         "pri": 52,
+         "time": 140608.000000,
+         "caller": "T52",
+         "msg": " example[52]"
+      },{
+         "pri": 53,
+         "time": 148877.000000,
+         "caller": "T53",
+         "msg": " example[53]"
+      },{
+         "pri": 54,
+         "time": 157464.000000,
+         "caller": "T54",
+         "msg": " example[54]"
+      },{
+         "pri": 55,
+         "time": 166375.000000,
+         "caller": "T55",
+         "msg": " example[55]"
+      },{
+         "pri": 56,
+         "time": 175616.000000,
+         "caller": "T56",
+         "msg": " example[56]"
+      },{
+         "pri": 57,
+         "time": 185193.000000,
+         "caller": "T57",
+         "msg": " example[57]"
+      },{
+         "pri": 58,
+         "time": 195112.000000,
+         "caller": "T58",
+         "msg": " example[58]"
+      },{
+         "pri": 59,
+         "time": 205379.000000,
+         "caller": "T59",
+         "msg": " example[59]"
+      },{
+         "pri": 60,
+         "time": 216000.000000,
+         "caller": "T60",
+         "msg": " example[60]"
+      },{
+         "pri": 61,
+         "time": 226981.000000,
+         "caller": "T61",
+         "msg": " example[61]"
+      },{
+         "pri": 62,
+         "time": 238328.000000,
+         "caller": "T62",
+         "msg": " example[62]"
+      },{
+         "pri": 63,
+         "time": 250047.000000,
+         "caller": "T63",
+         "msg": " example[63]"
+      },{
+         "pri": 64,
+         "time": 262144.000000,
+         "caller": "T64",
+         "msg": " example[64]"
+      },{
+         "pri": 65,
+         "time": 274625.000000,
+         "caller": "T65",
+         "msg": " example[65]"
+      },{
+         "pri": 66,
+         "time": 287496.000000,
+         "caller": "T66",
+         "msg": " example[66]"
+      },{
+         "pri": 67,
+         "time": 300763.000000,
+         "caller": "T67",
+         "msg": " example[67]"
+      },{
+         "pri": 68,
+         "time": 314432.000000,
+         "caller": "T68",
+         "msg": " example[68]"
+      },{
+         "pri": 69,
+         "time": 328509.000000,
+         "caller": "T69",
+         "msg": " example[69]"
+      },{
+         "pri": 70,
+         "time": 343000.000000,
+         "caller": "T70",
+         "msg": " example[70]"
+      },{
+         "pri": 71,
+         "time": 357911.000000,
+         "caller": "T71",
+         "msg": " example[71]"
+      },{
+         "pri": 72,
+         "time": 373248.000000,
+         "caller": "T72",
+         "msg": " example[72]"
+      },{
+         "pri": 73,
+         "time": 389017.000000,
+         "caller": "T73",
+         "msg": " example[73]"
+      },{
+         "pri": 74,
+         "time": 405224.000000,
+         "caller": "T74",
+         "msg": " example[74]"
+      },{
+         "pri": 75,
+         "time": 421875.000000,
+         "caller": "T75",
+         "msg": " example[75]"
+      },{
+         "pri": 76,
+         "time": 438976.000000,
+         "caller": "T76",
+         "msg": " example[76]"
+      },{
+         "pri": 77,
+         "time": 456533.000000,
+         "caller": "T77",
+         "msg": " example[77]"
+      },{
+         "pri": 78,
+         "time": 474552.000000,
+         "caller": "T78",
+         "msg": " example[78]"
+      },{
+         "pri": 79,
+         "time": 493039.000000,
+         "caller": "T79",
+         "msg": " example[79]"
+      },{
+         "pri": 80,
+         "time": 512000.000000,
+         "caller": "T80",
+         "msg": " example[80]"
+      },{
+         "pri": 81,
+         "time": 531441.000000,
+         "caller": "T81",
+         "msg": " example[81]"
+      },{
+         "pri": 82,
+         "time": 551368.000000,
+         "caller": "T82",
+         "msg": " example[82]"
+      },{
+         "pri": 83,
+         "time": 571787.000000,
+         "caller": "T83",
+         "msg": " example[83]"
+      },{
+         "pri": 84,
+         "time": 592704.000000,
+         "caller": "T84",
+         "msg": " example[84]"
+      },{
+         "pri": 85,
+         "time": 614125.000000,
+         "caller": "T85",
+         "msg": " example[85]"
+      },{
+         "pri": 86,
+         "time": 636056.000000,
+         "caller": "T86",
+         "msg": " example[86]"
+      },{
+         "pri": 87,
+         "time": 658503.000000,
+         "caller": "T87",
+         "msg": " example[87]"
+      },{
+         "pri": 88,
+         "time": 681472.000000,
+         "caller": "T88",
+         "msg": " example[88]"
+      },{
+         "pri": 89,
+         "time": 704969.000000,
+         "caller": "T89",
+         "msg": " example[89]"
+      },{
+         "pri": 90,
+         "time": 729000.000000,
+         "caller": "T90",
+         "msg": " example[90]"
+      },{
+         "pri": 91,
+         "time": 753571.000000,
+         "caller": "T91",
+         "msg": " example[91]"
+      },{
+         "pri": 92,
+         "time": 778688.000000,
+         "caller": "T92",
+         "msg": " example[92]"
+      },{
+         "pri": 93,
+         "time": 804357.000000,
+         "caller": "T93",
+         "msg": " example[93]"
+      },{
+         "pri": 94,
+         "time": 830584.000000,
+         "caller": "T94",
+         "msg": " example[94]"
+      },{
+         "pri": 95,
+         "time": 857375.000000,
+         "caller": "T95",
+         "msg": " example[95]"
+      },{
+         "pri": 96,
+         "time": 884736.000000,
+         "caller": "T96",
+         "msg": " example[96]"
+      },{
+         "pri": 97,
+         "time": 912673.000000,
+         "caller": "T97",
+         "msg": " example[97]"
+      },{
+         "pri": 98,
+         "time": 941192.000000,
+         "caller": "T98",
+         "msg": " example[98]"
+      },{
+         "pri": 99,
+         "time": 970299.000000,
+         "caller": "T99",
+         "msg": " example[99]"
+      },{
+         "pri": 100,
+         "time": 1000000.000000,
+         "caller": "T100",
+         "msg": " example[100]"
+      },{
+         "pri": 101,
+         "time": 1030301.000000,
+         "caller": "T101",
+         "msg": " example[101]"
+      },{
+         "pri": 102,
+         "time": 1061208.000000,
+         "caller": "T102",
+         "msg": " example[102]"
+      },{
+         "pri": 103,
+         "time": 1092727.000000,
+         "caller": "T103",
+         "msg": " example[103]"
+      },{
+         "pri": 104,
+         "time": 1124864.000000,
+         "caller": "T104",
+         "msg": " example[104]"
+      }
+   ]
+}
diff --git a/tests/expected/dmesg/kmsg-file-printk-caller b/tests/expected/dmesg/kmsg-file-printk-caller
new file mode 100644
index 000000000..785d730a5
--- /dev/null
+++ b/tests/expected/dmesg/kmsg-file-printk-caller
@@ -0,0 +1,115 @@
+{
+   "dmesg": [
+      {
+         "pri": 5,
+         "time":     0.000000,
+         "caller": "T0",
+         "msg": "Linux version 6.6.4-arch1-1 (linux@archlinux) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Mon, 04 Dec 2023 00:29:19 +0000"
+      },{
+         "pri": 6,
+         "time":     0.000000,
+         "caller": "T1",
+         "msg": "Command line: initrd=\\ucode.img initrd=\\initramfs-linux.img rw cryptdevice=/dev/nvme0n1p3:system:discard root=/dev/mapper/system"
+      },{
+         "pri": 6,
+         "time":     0.000000,
+         "caller": "T2",
+         "msg": "BIOS-provided physical RAM map:"
+      },{
+         "pri": 6,
+         "time":     0.000000,
+         "caller": "T3",
+         "msg": "BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable"
+      },{
+         "pri": 6,
+         "time":     0.000000,
+         "caller": "T4",
+         "msg": "BIOS-e820: [mem 0x000000000009f000-0x00000000000bffff] reserved"
+      },{
+         "pri": 6,
+         "time":     0.000000,
+         "caller": "T5",
+         "msg": "BIOS-e820: [mem 0x0000000000100000-0x0000000009afffff] usable"
+      },{
+         "pri": 6,
+         "time":     0.000000,
+         "caller": "T6",
+         "msg": "BIOS-e820: [mem 0x0000000009b00000-0x0000000009dfffff] reserved"
+      },{
+         "pri": 6,
+         "time":     0.000000,
+         "caller": "T7",
+         "msg": "BIOS-e820: [mem 0x0000000009e00000-0x0000000009efffff] usable"
+      },{
+         "pri": 6,
+         "time":     0.000000,
+         "caller": "T8",
+         "msg": "BIOS-e820: [mem 0x0000000009f00000-0x0000000009f3bfff] ACPI NVS"
+      },{
+         "pri": 6,
+         "time":     0.000000,
+         "caller": "T9",
+         "msg": "BIOS-e820: [mem 0x0000000009f3c000-0x000000004235ffff] usable"
+      },{
+         "pri": 6,
+         "time":     0.000000,
+         "caller": "T10",
+         "msg": "BIOS-e820: [mem 0x0000000042360000-0x000000004455ffff] reserved"
+      },{
+         "pri": 6,
+         "time":     0.367657,
+         "caller": "T11",
+         "msg": "ACPI: \\_SB_.PCI0.GP19.NHI1.PWRS: New power resource"
+      },{
+         "pri": 6,
+         "time":     0.368615,
+         "caller": "T12",
+         "msg": "ACPI: \\_SB_.PCI0.GP19.XHC4.PWRS: New power resource"
+      },{
+         "pri": 6,
+         "time":     0.376316,
+         "caller": "T13",
+         "msg": "ACPI: \\_SB_.PRWL: New power resource"
+      },{
+         "pri": 6,
+         "time":     0.376343,
+         "caller": "T14",
+         "msg": "ACPI: \\_SB_.PRWB: New power resource"
+      },{
+         "pri": 6,
+         "time":     0.377373,
+         "caller": "T15",
+         "msg": "ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])"
+      },{
+         "pri": 6,
+         "time":     0.377378,
+         "caller": "T16",
+         "msg": "acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]"
+      },{
+         "pri": 6,
+         "time":     0.377569,
+         "caller": "T17",
+         "msg": "acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug AER]"
+      },{
+         "pri": 6,
+         "time":     0.377933,
+         "caller": "T18",
+         "msg": "acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR DPC]"
+      },{
+         "pri": 6,
+         "time":     0.378458,
+         "caller": "T19",
+         "msg": "PCI host bridge to bus 0000:00"
+      },{
+         "pri": 6,
+         "time":     0.378459,
+         "caller": "T20",
+         "msg": "pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]"
+      },{
+         "pri": 6,
+         "time":     0.378461,
+         "caller": "T21",
+         "msg": "pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]"
+      }
+   ]
+}
diff --git a/tests/expected/dmesg/limit-kmsg-printk-caller b/tests/expected/dmesg/limit-kmsg-printk-caller
new file mode 100644
index 000000000..2ea07d4c8
--- /dev/null
+++ b/tests/expected/dmesg/limit-kmsg-printk-caller
@@ -0,0 +1,11 @@
+[    0.367657] [    T11] ACPI: \_SB_.PCI0.GP19.NHI1.PWRS: New power resource
+[    0.368615] [    T12] ACPI: \_SB_.PCI0.GP19.XHC4.PWRS: New power resource
+[    0.376316] [    T13] ACPI: \_SB_.PRWL: New power resource
+[    0.376343] [    T14] ACPI: \_SB_.PRWB: New power resource
+[    0.377373] [    T15] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
+[    0.377378] [    T16] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
+[    0.377569] [    T17] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug AER]
+[    0.377933] [    T18] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR DPC]
+[    0.378458] [    T19] PCI host bridge to bus 0000:00
+[    0.378459] [    T20] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
+[    0.378461] [    T21] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
diff --git a/tests/ts/dmesg/colors-kmsg-printk-caller b/tests/ts/dmesg/colors-kmsg-printk-caller
new file mode 100755
index 000000000..513ca82d4
--- /dev/null
+++ b/tests/ts/dmesg/colors-kmsg-printk-caller
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
+TS_DESC="colors-kmsg-prtk-caller"
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
+$TS_HELPER_DMESG --color=always -K $TS_SELF/kmsg-input-printk-caller -x >> $TS_OUTPUT 2>/dev/null
+
+ts_finalize
diff --git a/tests/ts/dmesg/console-levels-kmsg-printk-caller b/tests/ts/dmesg/console-levels-kmsg-printk-caller
new file mode 100755
index 000000000..00b8b3681
--- /dev/null
+++ b/tests/ts/dmesg/console-levels-kmsg-printk-caller
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
+TS_DESC="levels-kmsg-prtk-caller"
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
+	$TS_HELPER_DMESG -K $TS_SELF/kmsg-input-printk-caller -l $I >> $TS_OUTPUT 2>/dev/null
+done
+
+$TS_HELPER_DMESG -K $TS_SELF/kmsg-input-printk-caller -l err+ >> $TS_OUTPUT 2>/dev/null
+$TS_HELPER_DMESG -K $TS_SELF/kmsg-input-printk-caller -l emerg+ >> $TS_OUTPUT 2>/dev/null
+$TS_HELPER_DMESG -K $TS_SELF/kmsg-input-printk-caller -l +err >> $TS_OUTPUT 2>/dev/null
+$TS_HELPER_DMESG -K $TS_SELF/kmsg-input-printk-caller -l +debug >> $TS_OUTPUT 2>/dev/null
+$TS_HELPER_DMESG -K $TS_SELF/kmsg-input-printk-caller -l + 2>> $TS_OUTPUT >/dev/null
+
+ts_finalize
diff --git a/tests/ts/dmesg/decode-kmsg-printk-caller b/tests/ts/dmesg/decode-kmsg-printk-caller
new file mode 100755
index 000000000..d05b9fb68
--- /dev/null
+++ b/tests/ts/dmesg/decode-kmsg-printk-caller
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
+TS_DESC="decode-kmsg-prtk-caller"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_DMESG"
+
+export TZ="GMT"
+export DMESG_TEST_BOOTIME="1234567890.123456"
+
+$TS_HELPER_DMESG -x -K $TS_SELF/kmsg-input-printk-caller >> $TS_OUTPUT 2>/dev/null
+
+ts_finalize
diff --git a/tests/ts/dmesg/delta-kmsg-printk-caller b/tests/ts/dmesg/delta-kmsg-printk-caller
new file mode 100755
index 000000000..020b82357
--- /dev/null
+++ b/tests/ts/dmesg/delta-kmsg-printk-caller
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
+TS_DESC="delta-kmsg-prtk-caller"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_DMESG"
+
+export TZ="GMT"
+export DMESG_TEST_BOOTIME="1234567890.123456"
+
+$TS_HELPER_DMESG -d -K $TS_SELF/kmsg-input-printk-caller >> $TS_OUTPUT 2>/dev/null
+
+ts_finalize
diff --git a/tests/ts/dmesg/facilities-kmsg-printk-caller b/tests/ts/dmesg/facilities-kmsg-printk-caller
new file mode 100755
index 000000000..bec301516
--- /dev/null
+++ b/tests/ts/dmesg/facilities-kmsg-printk-caller
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
+TS_DESC="facilities-kmsg-prtk-caller"
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
+	$TS_HELPER_DMESG -K $TS_SELF/kmsg-input-printk-caller -f $I -x >> $TS_OUTPUT 2>/dev/null
+done
+
+ts_finalize
diff --git a/tests/ts/dmesg/indentation-kmsg-printk-caller b/tests/ts/dmesg/indentation-kmsg-printk-caller
new file mode 100755
index 000000000..53e549b62
--- /dev/null
+++ b/tests/ts/dmesg/indentation-kmsg-printk-caller
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
+TS_DESC="indentation-kmsg-prtk-caller"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_DMESG"
+
+export TZ="GMT"
+export DMESG_TEST_BOOTIME="1234567890.123456"
+
+$TS_HELPER_DMESG -K $TS_SELF/newlines-kmsg-printk-caller >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+$TS_HELPER_DMESG -K $TS_SELF/newlines-kmsg-printk-caller -x >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+$TS_HELPER_DMESG --time-format=delta --kmsg-file $TS_SELF/newlines-kmsg-printk-caller >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+$TS_HELPER_DMESG --time-format=notime --kmsg-file $TS_SELF/newlines-kmsg-printk-caller >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+$TS_HELPER_DMESG --time-format=reltime --kmsg-file $TS_SELF/newlines-kmsg-printk-caller >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+$TS_HELPER_DMESG --time-format=ctime --kmsg-file $TS_SELF/newlines-kmsg-printk-caller >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+$TS_HELPER_DMESG --time-format=iso --kmsg-file $TS_SELF/newlines-kmsg-printk-caller >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+ts_finalize
diff --git a/tests/ts/dmesg/input-syslog-printk-caller b/tests/ts/dmesg/input-syslog-printk-caller
new file mode 100644
index 000000000..5fcff6abe
--- /dev/null
+++ b/tests/ts/dmesg/input-syslog-printk-caller
@@ -0,0 +1,105 @@
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
diff --git a/tests/ts/dmesg/json-kmsg-printk-caller b/tests/ts/dmesg/json-kmsg-printk-caller
new file mode 100755
index 000000000..cb6c5e4a8
--- /dev/null
+++ b/tests/ts/dmesg/json-kmsg-printk-caller
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
+TS_DESC="json-kmsg-prtk-caller"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_DMESG"
+
+export TZ="GMT"
+export DMESG_TEST_BOOTIME="1234567890.123456"
+
+$TS_HELPER_DMESG -J -K $TS_SELF/kmsg-input-printk-caller >> $TS_OUTPUT 2>/dev/null
+
+ts_finalize
diff --git a/tests/ts/dmesg/json-syslog-printk-caller b/tests/ts/dmesg/json-syslog-printk-caller
new file mode 100755
index 000000000..10dfaa423
--- /dev/null
+++ b/tests/ts/dmesg/json-syslog-printk-caller
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
+TS_DESC="json-syslog-prtk-caller"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_DMESG"
+
+export TZ="GMT"
+export DMESG_TEST_BOOTIME="1234567890.123456"
+
+$TS_HELPER_DMESG -J -F $TS_SELF/input-syslog-printk-caller >> $TS_OUTPUT 2>/dev/null
+
+ts_finalize
diff --git a/tests/ts/dmesg/kmsg-file-printk-caller b/tests/ts/dmesg/kmsg-file-printk-caller
new file mode 100755
index 000000000..a01fc723f
--- /dev/null
+++ b/tests/ts/dmesg/kmsg-file-printk-caller
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
+TS_DESC="kmsg-file-prtk-caller"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_DMESG"
+
+export TZ="GMT"
+export DMESG_TEST_BOOTIME="1234567890.123456"
+
+$TS_HELPER_DMESG -J -K $TS_SELF/kmsg-input-printk-caller >> $TS_OUTPUT 2>/dev/null
+
+ts_finalize
diff --git a/tests/ts/dmesg/kmsg-input-printk-caller b/tests/ts/dmesg/kmsg-input-printk-caller
new file mode 100644
index 0000000000000000000000000000000000000000..8d67f11cad7988469dd5e4a7c8589d2b744168bb
GIT binary patch
literal 2187
zcmbW2TW{hx6oB`+zv4*yQZ$g-aqb9dAw>nL(1<WMu@wr5q0uIBlmsaMe(Z!%<LSbv
zlRV_&oX=m5?PI-*_}S}*L6Xp7utfdGINQI%ffi-VGB6ZF(Rx7<zTh5)+e9?}BOdF!
z4&3g-5N;n_w*#0cs)9j9DnS;)U3i#(h9u&x{5s-+Rh*O^P!$a;r~`jv@Mj))i}85o
zE!X$o=fm05g&E7bfHb(LVT}TW9MyKP4WAG{ZvHa5STe?am!)ZtMZlG)1928tMKt*L
zRS)+ei>MN(yY|bvJxI4@ul|L)xi~^toboE7hd88zJAS>(4k<+$&WTf=%8I5=6qjL8
zL{KnRHJ_wGp3~y4X%}XyWTy5<(<i@|7wiy6G=lu)RK`5fuo%vO$2uZ}NFk&Np_Ymq
zSfw-t^eTS4ee|SPHr;Nw&#*6pO+p1wlYrWFpuOc}8Mxs*4lHO%ivx`WQkRhWRV1!e
z+ekYQM9I;RfW|eTy?GCe&cL>#DIv|PNctWrvM4)R641H|6j_w>Xm5!~<TDIiZwm7-
zzR063A?@o(63R$TCHk+9SYEssT|x4A;}=U!)6d9uCN)C3#4rurY}Eyf`{GX=5bJ8~
zkJgIkPLcB9VOyC`rdaX5E_?^(^awdS(n8E1wlBhFN)n9|Ed%RqqI#M5ZQ^RbA?jUX
z8U!0{B6&w#e0{tu#TOq(XrztM{s%F-j4(OEB&LMW&j_9%Snyf_qau!W6jmZ*&u|;D
zG>9`^*ARl$W?%BV9-k?ldhrsgAzE!IqaTEM4Bp&BLu5I;BEtH~cO7{0q1@*=E2<J!
z<JXF2yw12R+r~Q>`rZuOgoXd{t50_+&G=U{e+uLK1x&nez2zyV<oO2t&m;f4zZ}m7
zqMIAIAAgy;<H0BK<h*s-_}RiwH|(~bdC4zNf@;f(6e31T$apT!y0G#mo;zVxp6t2m
zc=16E4G9gK&(ycA3tN{oc$zZCOFYY}f+ajvd?e`4&b`?f#IqaZ!6r`P>I9F=1>Ae?
zN1ZTtvNT;9I=e5X!3!%Z*fi6iV$cjaAI4@s(=@e-Y$sJk{XC4<txuhL=c$8#E-qNb
x49;7GD7oR*gkzjV>?paPL2n~_e!=^1N$^$A^$pxgsfs@$5!EG7)Tlp__yL<dZm0kN

literal 0
HcmV?d00001

diff --git a/tests/ts/dmesg/limit-kmsg-printk-caller b/tests/ts/dmesg/limit-kmsg-printk-caller
new file mode 100755
index 000000000..4d4d9912d
--- /dev/null
+++ b/tests/ts/dmesg/limit-kmsg-printk-caller
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
+TS_DESC="limit-kmsg-prtk-caller"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_DMESG"
+
+export TZ="GMT"
+export DMESG_TEST_BOOTIME="1234567890.123456"
+
+$TS_HELPER_DMESG --since @1234567890.124 --until @1234567991 -K $TS_SELF/kmsg-input-printk-caller \
+	>> $TS_OUTPUT 2> $TS_ERRLOG
+
+ts_finalize
diff --git a/tests/ts/dmesg/newlines-kmsg-printk-caller b/tests/ts/dmesg/newlines-kmsg-printk-caller
new file mode 100644
index 0000000000000000000000000000000000000000..574d2177796677b73f1efcf273005169ed832c60
GIT binary patch
literal 152
zcmXrjF#tkco#e!voYW%Q5CiL+%)C^Es??%<E(Svb9YY;M128~RV`!b1TFwPh$Hia-
tQeuRm#K^j&Jf91MLCT7`7>o^cjC71K)EQfsWE7>QazV)4{GwE-1^{d2D<=Q|

literal 0
HcmV?d00001

-- 
2.43.0

