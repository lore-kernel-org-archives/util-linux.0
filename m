Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="f+vNCmO4"
Received: from mail-io1-xd61.google.com (mail-io1-xd61.google.com [IPv6:2607:f8b0:4864:20::d61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A72D68
	for <util-linux@vger.kernel.org>; Wed,  6 Dec 2023 13:04:55 -0800 (PST)
Received: by mail-io1-xd61.google.com with SMTP id ca18e2360f4ac-7b6e9f335dcso8376939f.1
        for <util-linux@vger.kernel.org>; Wed, 06 Dec 2023 13:04:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701896694; x=1702501494;
        h=content-transfer-encoding:message-id:date:subject:cc:to:from
         :dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/7kEjiAC4FVivXuXTttkNaWkqS2PDtq4wrPICW2zZ0=;
        b=OyHUEDYzgLVXhaJSAITsXmrwqP+Za0e8JTK0JXAZMerKeZkRz2n8xUkBoNHn/Pjp/0
         vEC1albkThyrj2PC8K/IJHe/KYl94ORrpAgI/6BU2W77iS0pvXoC+rQ3YWdFXee+ZDvz
         DAIeegHn+DQ++TqXSC8dcBHGiI/9oR+aIfpl0MeP9QRbzXCtsYq++HCinT0Le52+Kak2
         IlY+es23TV+cATWEPhhKzKym2IeYL+sO1gHRi7qsfPz3nUIMkxnsPewFww0kVaUwESEJ
         xtBBD5jGHY5yLEXmTgtfMGAGcEm1Wi/z8Xo9Avs+3HrknynCmTOi+kRHa+Z4YT8T/WwM
         7k0A==
X-Gm-Message-State: AOJu0Yw/alNdl+CwblYE3Xff8gWJKM03RzBvEypAbAFJ96Pb8UkSDQd8
	FMwHWhB3MuZ9AlXrRt2JjWKJ6aHx7sN9BS6O+CcmV3l3V9Kfy8ofz9a/
X-Google-Smtp-Source: AGHT+IHPBF/4tipa1+ZZ/eJZzM2Wx/eGebX3AeYHlWH2e2KtpYm3oscUCgDWjFl039LQnr0Xdybji7ZPQ+oj
X-Received: by 2002:a6b:c90a:0:b0:7b6:eb2a:24a4 with SMTP id z10-20020a6bc90a000000b007b6eb2a24a4mr911539iof.42.1701896694490;
        Wed, 06 Dec 2023 13:04:54 -0800 (PST)
Received: from smtp.aristanetworks.com ([74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id c14-20020a02a40e000000b00469210113b6sm29468jal.66.2023.12.06.13.04.54
        for <util-linux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Dec 2023 13:04:54 -0800 (PST)
X-Relaying-Domain: arista.com
Received: from us113.sjc.aristanetworks.com (us113.sjc.aristanetworks.com [10.242.240.8])
	by smtp.aristanetworks.com (Postfix) with ESMTP id 925C0402056;
	Wed,  6 Dec 2023 13:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1701896693;
	bh=r/7kEjiAC4FVivXuXTttkNaWkqS2PDtq4wrPICW2zZ0=;
	h=From:To:Cc:Subject:Date:From;
	b=f+vNCmO4/BRfP/1MFb3FJ9do7N5CFBOr0SoHH4vra96TyxwwuAlSz5t94660eE864
	 YJZNztdaQU/AWktJ50kMHTWIgP+k49L+BoPE3j/Orf50KJID1l0IH64tqsOICyrncZ
	 XsiGCp4AkB3XNy0YFsj3oznRf4VmZXpbTZ4Uf0SQGNLrViSAVl90tUZUDxOfiDr+cE
	 9hZNdvQ7Hx+FD8yJEXg1mJ+rNa11hoAd8PssjCPyQY//4m1mpoE/BJi9vXHshZ3v5B
	 ejVVArvWBMGyOznizsDcdIuIOCAzTul5uxbWzMbFOAxk38kbUoMAcJmJW4bdFZuqcG
	 FI+rd2Lp4uYwA==
Received: by us113.sjc.aristanetworks.com (Postfix, from userid 10383)
	id 886EFB8409E0; Wed,  6 Dec 2023 13:04:53 -0800 (PST)
From: Edward Chron <echron@arista.com>
To: util-linux@vger.kernel.org
Cc: colona@arista.com,
	echron@arista.com
Subject: [PATCH] util-linux/sys-utils dmesg add PRINTK_CALLER id support
Date: Wed,  6 Dec 2023 13:04:49 -0800
Message-ID: <20231206210449.27011-1-echron@arista.com>
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
Code level patch applied against: ~2.39.3 - latest code pulled from
           git.github.com:util-linux/util-linux.git

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
    kern  :info  : [ 9830.456898] [  T98982] cgroup: fork rejected by pids
    kern  :info  : [14301.158878] [ T137336] cgroup: fork rejected by pids
    kern  :info  : [18980.803190] [T1637865] cgroup: fork rejected by pids
             
    > dmesg -S -x
    ...      
    kern  :info  : [  520.899558] [ T3919] hub 3-3:1.0: USB hub found
    ...
    kern  :info  : [ 9830.456898] [T98982] cgroup: fork rejected by pids
    kern  :info  : [14301.158878] [T137336] cgroup: fork rejected by pids
    kern  :info  : [18980.803190] [T1637865] cgroup: fork rejected by pids

This is the only difference seen with PRINTK_CALLER configured and
printing between the dmesg /dev/kmsg interface and the dmesg -S syslog
interface.   

Adding PRINTK_CALLER id optional dmesg field support to dmesg allows
utilities like kdump used with Fedora produce a kexec-dmesg.log file that
produces dmesgs with the PRINTK_CALLER field included. That and other
utilities that use dmesg (/dev/kmsg) interface need this support.

Signed-off-by: Ivan Delalande <colona@arista.com>
Signed-off-by: Edward Chron <echron@arista.com>

---
 sys-utils/dmesg.c | 108 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 1 deletion(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 79e1c1690..9662dfb15 100644
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
@@ -60,6 +61,9 @@
 /* Return size of the log buffer */
 #define SYSLOG_ACTION_SIZE_BUFFER   10
 
+static const char PROC_SYS_KERN_PID_MAX[] = "/proc/sys/kernel/pid_max";
+#define PID_CHARS_MAX 16
+
 /*
  * Color scheme
  */
@@ -216,6 +220,7 @@ struct dmesg_control {
 			force_prefix:1;	/* force timestamp and decode prefix
 					   on each line */
 	int		indent;		/* due to timestamps if newline */
+	size_t          caller_id_size;   /* PRINTK_CALLERID max field size */
 };
 
 struct dmesg_record {
@@ -225,6 +230,7 @@ struct dmesg_record {
 	int		level;
 	int		facility;
 	struct timeval  tv;
+	char		caller_id[PID_CHARS_MAX];
 
 	const char	*next;		/* buffer with next unparsed record */
 	size_t		next_size;	/* size of the next buffer */
@@ -237,6 +243,7 @@ struct dmesg_record {
 		(_r)->level = -1; \
 		(_r)->tv.tv_sec = 0; \
 		(_r)->tv.tv_usec = 0; \
+		(_r)->caller_id[0] = 0; \
 	} while (0)
 
 static int process_kmsg(struct dmesg_control *ctl);
@@ -532,6 +539,47 @@ static int get_syslog_buffer_size(void)
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
+ * a value of that size. The /proc field defined by PROC_SYS_KERN_PID_MAX
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
+	char taskmax[PID_CHARS_MAX];
+	ssize_t rdsize;
+	int fd;
+
+	fd = open(PROC_SYS_KERN_PID_MAX, O_RDONLY);
+	if (fd == -1)
+		return (size_t)5;
+
+	memset(taskmax, 0, sizeof(taskmax));
+
+	rdsize = read(fd, taskmax, sizeof(taskmax));
+	if (rdsize == -1)
+		return (size_t)5;
+
+	return strnlen(taskmax, sizeof(taskmax));
+}
+
 /*
  * Reads messages from regular file by mmap
  */
@@ -706,6 +754,35 @@ static const char *skip_item(const char *begin, const char *end, const char *sep
 	return begin;
 }
 
+/*
+ * Checks to see if the caller (caller id) field is present in the kmsg record.
+ * This is true if the PRINTK_CALLER config option has been set in the kernel.
+ *
+ * If the caller_id is found in the kmsg buffer then return the id and id type
+ * to the caller in dmesg caller_id. Returns true if found else return false.
+ *
+ */
+static const char *parse_callerid(const char *p_str, const char *end,
+				  struct dmesg_record *p_drec)
+{
+	static const char cid[] = "caller=";
+	const char *p_after;
+	const char *p_next;
+	size_t cid_size;
+	char *p_cid;
+
+	p_cid = strstr(p_str, cid);
+	if (p_cid != NULL && p_drec != NULL) {
+		p_next = p_cid + sizeof(cid)-1;
+		p_after = skip_item(p_next, end, ",;");
+		cid_size = p_after - p_next - 1;
+		memset(p_drec->caller_id, 0, sizeof(p_drec->caller_id));
+		strncpy(p_drec->caller_id, p_next, cid_size);
+		return p_after;
+	}
+	return p_str;
+}
+
 /*
  * Parses one record from syslog(2) buffer
  */
@@ -1079,6 +1156,29 @@ full_output:
 			color_disable();
 	}
 
+	if (rec->caller_id[0] != 0) {
+		size_t cid_len = strnlen(rec->caller_id, PID_CHARS_MAX);
+		ssize_t numspaces;
+		char strbuf[PID_CHARS_MAX];
+
+		numspaces = ctl->caller_id_size - cid_len;
+
+		memset(strbuf, 0, sizeof(strbuf));
+		if (numspaces > 0)
+			memset(strbuf, ' ', numspaces);
+
+		if (ctl->json) {
+			ul_jsonwrt_value_s(&ctl->jfmt, "caller", rec->caller_id);
+		} else {
+			char cidbuf[PID_CHARS_MAX];
+
+			memset(cidbuf, 0, sizeof(cidbuf));
+			sprintf(cidbuf, "[%s%s] ", strbuf, rec->caller_id);
+			ctl->indent += strnlen(cidbuf, PID_CHARS_MAX);
+			fputs(cidbuf, stdout);
+		}
+	}
+
 	/*
 	 * A kernel message may contain several lines of output, separated
 	 * by '\n'.  If the timestamp and decode outputs are forced then each
@@ -1207,6 +1307,8 @@ static int init_kmsg(struct dmesg_control *ctl)
 		return -1;
 	}
 
+	ctl->caller_id_size = max_threads_id_size();
+
 	return 0;
 }
 
@@ -1262,7 +1364,10 @@ static int parse_kmsg_record(struct dmesg_control *ctl,
 		goto mesg;
 
 	/* D) optional fields (ignore) */
-	p = skip_item(p, end, ";");
+	p = skip_item(p, end, ",;");
+
+	/* Include optional PRINTK_CALLER field if it is present */
+	p = parse_callerid(p, end, rec);
 
 mesg:
 	/* E) message text */
@@ -1390,6 +1495,7 @@ int main(int argc, char *argv[])
 		.kmsg = -1,
 		.time_fmt = DMESG_TIMEFTM_TIME,
 		.indent = 0,
+		.caller_id_size = 0,
 	};
 	int colormode = UL_COLORMODE_UNDEF;
 	enum {
-- 
2.41.0

