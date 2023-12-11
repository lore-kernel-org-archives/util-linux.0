Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="26soqjy/"
Received: from mail-pl1-x662.google.com (mail-pl1-x662.google.com [IPv6:2607:f8b0:4864:20::662])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C136994
	for <util-linux@vger.kernel.org>; Mon, 11 Dec 2023 09:23:41 -0800 (PST)
Received: by mail-pl1-x662.google.com with SMTP id d9443c01a7336-1d2eb06ab11so18176025ad.1
        for <util-linux@vger.kernel.org>; Mon, 11 Dec 2023 09:23:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702315421; x=1702920221;
        h=content-transfer-encoding:message-id:date:subject:cc:to:from
         :dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHuL/arjph987tbxZY0rWrmGZJhXgkw50TayHjZUE+g=;
        b=sCLKYf5sLs6/GMAvt+1zBFL7VGJaGMYbGi7dllrpKGQP3uLGsm0yhtnqCG//Fe3fVF
         1zZ6iz08d3BEtDIURutlXVzPXUpWsyxXYRmSx+HrW2HbmIA8KCHn+s0opNLFoG50G5fh
         eYRxBfcAE9l8T8IJ2ckT37NmssUBnpTZO0jlvUH2gwj2quHBD2Fgj50nn4flnaeCox+Q
         NrkBoKyq+3QIRnuoEf1+2AhL0xW5nk0t0vPUbrVQLJ3NlV2Ghwaw+zRcxa3pj+hwPnuQ
         rbx2sfq9PaQl3WzZBh/2Bt9zQu8b6ceCvebGnoNU+2/K0kgwzFRFVfPQXSax/IRU+dNv
         7IbQ==
X-Gm-Message-State: AOJu0YyXn6Cxi/Ixc3TfhUb5i66Y+aoG8vujN6ZjQO3AQz9fs7Z5EzPw
	Sey6vMyd0HPgxgyCFA/ijYPvVePPxOQk7xTr4cBFXUZDuJZlMzTaEMFw
X-Google-Smtp-Source: AGHT+IGsU9nVbyoCKJXQV9lEWuHMwVlNicYsJhprD0ttoFxCd5mVB2hpkbAg1FwDF/pQ3gkE3+o/FgW0VZ7o
X-Received: by 2002:a17:902:e842:b0:1d0:c601:ce50 with SMTP id t2-20020a170902e84200b001d0c601ce50mr2307187plg.116.1702315421154;
        Mon, 11 Dec 2023 09:23:41 -0800 (PST)
Received: from smtp.aristanetworks.com ([74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id ba1-20020a170902720100b001d0b4c8f81bsm456847plb.33.2023.12.11.09.23.40
        for <util-linux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Dec 2023 09:23:41 -0800 (PST)
X-Relaying-Domain: arista.com
Received: from us113.sjc.aristanetworks.com (us113.sjc.aristanetworks.com [10.242.240.8])
	by smtp.aristanetworks.com (Postfix) with ESMTP id 6233D400F82;
	Mon, 11 Dec 2023 09:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1702315420;
	bh=GHuL/arjph987tbxZY0rWrmGZJhXgkw50TayHjZUE+g=;
	h=From:To:Cc:Subject:Date:From;
	b=26soqjy/cdvF76wTcPMJeMrrtPu3cIk+eLK6uXFaevhwmzrRffzdh36liX6lGhMgi
	 hNohbIFFloZzX5bRXyZtO/kLTIfpsC7v7v3RCXz79scL2NinUGjAWPcmJe9wzRCSmo
	 yi3fU2d1kHMqeFkSu7CWHMUD9myzA5ulQfhFwCrHuBSSJ677kfsv/BNLvWp6w802q6
	 njbDOjbJ1GTdzg/m6/V/CYL2Wo+Vk0X9ZAwFxNvCNrr2BA7yY/BVjcCI6YDbo0b7OP
	 xeH4etSHDxjWbxe5C8fXdE3TmLPQ+k6IrJf2Qgfucyu95JLGbYcdO+th4OBBAHdBuK
	 NeJ8PBVpSC8ow==
Received: by us113.sjc.aristanetworks.com (Postfix, from userid 10383)
	id 5668BB840777; Mon, 11 Dec 2023 09:23:40 -0800 (PST)
From: Edward Chron <echron@arista.com>
To: util-linux@vger.kernel.org
Cc: colona@arista.com,
	echron@arista.com
Subject: [PATCH] util-linux/sys-utils dmesg add PRINTK_CALLER support
Date: Mon, 11 Dec 2023 09:23:37 -0800
Message-ID: <20231211172337.31108-1-echron@arista.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>

Submission to Project: util-linux
Open Incident: #2906 at github.com/util-linux/util-linux/issues/2906
Component: util-linux/sys-utils
File: dmesg.c
Code level patch applied against: 2.39.3 - latest code pulled from
           git.github.com:util-linux/util-linux.git
Revision: #1 on 2023/12/08 per Review from Karel Zak

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
 include/pathnames.h |   3 ++
 sys-utils/dmesg.c   | 100 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 102 insertions(+), 1 deletion(-)

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
index 79e1c1690..fc7252539 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -8,6 +8,7 @@
  */
 #include <stdio.h>
 #include <getopt.h>
+#include <stdbool.h>
 #include <stdlib.h>
 #include <sys/klog.h>
 #include <sys/syslog.h>
@@ -36,6 +37,7 @@
 #include "mangle.h"
 #include "pager.h"
 #include "jsonwrt.h"
+#include "pathnames.h"
 
 /* Close the log.  Currently a NOP. */
 #define SYSLOG_ACTION_CLOSE          0
@@ -60,6 +62,11 @@
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
@@ -216,6 +223,7 @@ struct dmesg_control {
 			force_prefix:1;	/* force timestamp and decode prefix
 					   on each line */
 	int		indent;		/* due to timestamps if newline */
+	size_t          caller_id_size;   /* PRINTK_CALLERID max field size */
 };
 
 struct dmesg_record {
@@ -225,6 +233,7 @@ struct dmesg_record {
 	int		level;
 	int		facility;
 	struct timeval  tv;
+	char		caller_id[PID_CHARS_MAX];
 
 	const char	*next;		/* buffer with next unparsed record */
 	size_t		next_size;	/* size of the next buffer */
@@ -237,6 +246,7 @@ struct dmesg_record {
 		(_r)->level = -1; \
 		(_r)->tv.tv_sec = 0; \
 		(_r)->tv.tv_usec = 0; \
+		(_r)->caller_id[0] = 0; \
 	} while (0)
 
 static int process_kmsg(struct dmesg_control *ctl);
@@ -532,6 +542,45 @@ static int get_syslog_buffer_size(void)
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
@@ -706,6 +755,36 @@ static const char *skip_item(const char *begin, const char *end, const char *sep
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
@@ -1079,6 +1158,19 @@ full_output:
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
@@ -1207,6 +1299,8 @@ static int init_kmsg(struct dmesg_control *ctl)
 		return -1;
 	}
 
+	ctl->caller_id_size = max_threads_id_size();
+
 	return 0;
 }
 
@@ -1262,7 +1356,10 @@ static int parse_kmsg_record(struct dmesg_control *ctl,
 		goto mesg;
 
 	/* D) optional fields (ignore) */
-	p = skip_item(p, end, ";");
+	p = skip_item(p, end, ",;");
+
+	/* Include optional PRINTK_CALLER field if it is present */
+	p = parse_callerid(p, end, rec);
 
 mesg:
 	/* E) message text */
@@ -1390,6 +1487,7 @@ int main(int argc, char *argv[])
 		.kmsg = -1,
 		.time_fmt = DMESG_TIMEFTM_TIME,
 		.indent = 0,
+		.caller_id_size = 0,
 	};
 	int colormode = UL_COLORMODE_UNDEF;
 	enum {
-- 
2.43.0

