Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="aNKhEQFT"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8500CD0
	for <util-linux@vger.kernel.org>; Tue, 12 Dec 2023 10:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1702407208; bh=bpSD4+YZCQc1KQ8Z/Tst3S9rA1Ceh6+5C5kG/qkALzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aNKhEQFTlE1vr8bsgvSQc2gWh/cZFMRsqmt7oyEYcdxeLU5D1YnTOhD8ix/3K2ML9
	 oFd9/5Nf1Vguy9f4n/L8xhisjPWUCfBzx2xca4UTwU2AoWoQEO3TuYaPSfKQZXvcyh
	 ngp7Jn1V4sqSSSXQLRdlCax1H+4rUdlxk7AW3LzQ=
Date: Tue, 12 Dec 2023 19:53:28 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Edward Chron <echron@arista.com>
Cc: util-linux@vger.kernel.org, colona@arista.com
Subject: Re: [PATCH] util-linux/sys-utils dmesg add PRINTK_CALLER support
Message-ID: <e9dabb68-92a9-4217-a343-30e895960410@t-8ch.de>
References: <20231211172337.31108-1-echron@arista.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211172337.31108-1-echron@arista.com>

On 2023-12-11 09:23:37-0800, Edward Chron wrote:
> Submission to Project: util-linux
> Open Incident: #2906 at github.com/util-linux/util-linux/issues/2906
> Component: util-linux/sys-utils
> File: dmesg.c
> Code level patch applied against: 2.39.3 - latest code pulled from
>            git.github.com:util-linux/util-linux.git
> Revision: #1 on 2023/12/08 per Review from Karel Zak

[..]

> ---
>  include/pathnames.h |   3 ++
>  sys-utils/dmesg.c   | 100 +++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 102 insertions(+), 1 deletion(-)
> 
> diff --git a/include/pathnames.h b/include/pathnames.h
> index caf0e63d4..81fa405f6 100644
> --- a/include/pathnames.h
> +++ b/include/pathnames.h
> @@ -230,4 +230,7 @@
>  /* cgroup path */
>  #define _PATH_SYS_CGROUP	"/sys/fs/cgroup"
>  
> +/* Maximum number of PIDs system supports */
> +#define _PATH_PROC_PIDMAX	"/proc/sys/kernel/pid_max"
> +
>  #endif /* PATHNAMES_H */
> diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
> index 79e1c1690..fc7252539 100644
> --- a/sys-utils/dmesg.c
> +++ b/sys-utils/dmesg.c
> @@ -8,6 +8,7 @@
>   */
>  #include <stdio.h>
>  #include <getopt.h>
> +#include <stdbool.h>
>  #include <stdlib.h>
>  #include <sys/klog.h>
>  #include <sys/syslog.h>
> @@ -36,6 +37,7 @@
>  #include "mangle.h"
>  #include "pager.h"
>  #include "jsonwrt.h"
> +#include "pathnames.h"
>  
>  /* Close the log.  Currently a NOP. */
>  #define SYSLOG_ACTION_CLOSE          0
> @@ -60,6 +62,11 @@
>  /* Return size of the log buffer */
>  #define SYSLOG_ACTION_SIZE_BUFFER   10
>  
> +#define PID_CHARS_MAX sizeof(stringify_value(LONG_MAX))
> +#define PID_CHARS_DEFAULT sizeof(stringify_value(INT_MAX))
> +#define DMESG_CALLER_PREFIX "caller="
> +#define DMESG_CALLER_PREFIXSZ (sizeof(DMESG_CALLER_PREFIX)-1)
> +
>  /*
>   * Color scheme
>   */
> @@ -216,6 +223,7 @@ struct dmesg_control {
>  			force_prefix:1;	/* force timestamp and decode prefix
>  					   on each line */
>  	int		indent;		/* due to timestamps if newline */
> +	size_t          caller_id_size;   /* PRINTK_CALLERID max field size */
>  };
>  
>  struct dmesg_record {
> @@ -225,6 +233,7 @@ struct dmesg_record {
>  	int		level;
>  	int		facility;
>  	struct timeval  tv;
> +	char		caller_id[PID_CHARS_MAX];
>  
>  	const char	*next;		/* buffer with next unparsed record */
>  	size_t		next_size;	/* size of the next buffer */
> @@ -237,6 +246,7 @@ struct dmesg_record {
>  		(_r)->level = -1; \
>  		(_r)->tv.tv_sec = 0; \
>  		(_r)->tv.tv_usec = 0; \
> +		(_r)->caller_id[0] = 0; \
>  	} while (0)
>  
>  static int process_kmsg(struct dmesg_control *ctl);
> @@ -532,6 +542,45 @@ static int get_syslog_buffer_size(void)
>  	return n > 0 ? n : 0;
>  }
>  
> +/*
> + * Get the number of characters needed to hold the maximum number
> + * of tasks this system supports. This size of string could hold
> + * a thread id large enough for the highest thread id.
> + * This is needed to determine the number of characters reserved for
> + * the PRINTK_CALLER field if it has been configured in the Linux Kernel.
> + *
> + * The number of digits sets the max value since the value can't exceed
> + * a value of that size. The /proc field defined by _PATH_PROC_PIDMAX
> + * holds the maximum number of PID values that may be ussed by the system,
> + * so 0 to that value minus one.
> + *
> + * For determining the size of the PRINTK_CALLER field, we make the safe
> + * assumption that the number of threads >= number of cpus. This because
> + * the PRINTK_CALLER field can hold either a thread id or a CPU id value.
> + *
> + * If we can't access the pid max kernel proc entry we assign a default
> + * field size of 5 characters as that is what the old syslog interface
> + * uses as the reserved field size. This is justified because 32-bit Linux
> + * systems are limited to PID values between (0-32767).
> + *
> + */
> +static size_t max_threads_id_size(void)
> +{
> +	char taskmax[PID_CHARS_MAX] = {'\0'};
> +	ssize_t rdsize;
> +	int fd;
> +
> +	fd = open(_PATH_PROC_PIDMAX, O_RDONLY);
> +	if (fd == -1)
> +		return PID_CHARS_DEFAULT;
> +
> +	rdsize = read(fd, taskmax, sizeof(taskmax));
> +	if (rdsize == -1)
> +		return PID_CHARS_DEFAULT;
> +
> +	return strnlen(taskmax, sizeof(taskmax));
> +}
> +
>  /*
>   * Reads messages from regular file by mmap
>   */
> @@ -706,6 +755,36 @@ static const char *skip_item(const char *begin, const char *end, const char *sep
>  	return begin;
>  }
>  
> +/*
> + * Checks to see if the caller (caller id) field is present in the kmsg record.
> + * This is true if the PRINTK_CALLER config option has been set in the kernel.
> + *
> + * If the caller_id is found in the kmsg buffer then return the id and id type
> + * to the caller in dmesg caller_id. Returns string pointer to next value.
> + *
> + */
> +static const char *parse_callerid(const char *p_str, const char *end,
> +				  struct dmesg_record *p_drec)
> +{
> +	const char *p_after;
> +	const char *p_next;
> +	size_t cid_size;
> +	char *p_cid;
> +
> +	p_cid = strstr(p_str, DMESG_CALLER_PREFIX);

Could this be made a bit more robust to only look for the field in the
expected location and not all of the message?

> +	if (p_cid != NULL && p_drec != NULL) {
> +		p_next = p_cid + DMESG_CALLER_PREFIXSZ;
> +		p_after = skip_item(p_next, end, ",;");
> +		cid_size = p_after - p_next;
> +		if (cid_size < sizeof(p_drec->caller_id))
> +			xstrncpy(p_drec->caller_id, p_next, cid_size);
> +		else
> +			return p_str;
> +		return p_after;
> +	}
> +	return p_str;
> +}
> +
>  /*
>   * Parses one record from syslog(2) buffer
>   */
> @@ -1079,6 +1158,19 @@ full_output:
>  			color_disable();
>  	}
>  
> +	if (*rec->caller_id) {
> +		if (ctl->json) {
> +			ul_jsonwrt_value_s(&ctl->jfmt, "caller", rec->caller_id);
> +		} else {
> +			char cidbuf[PID_CHARS_MAX+3] = {'\0'};
> +
> +			sprintf(cidbuf, "[%*s] ",
> +				(char)ctl->caller_id_size - 1, rec->caller_id);
> +			ctl->indent += strnlen(cidbuf, PID_CHARS_MAX+3);

Use sizeof(cidbuf);

> +			fputs(cidbuf, stdout);
> +		}
> +	}
> +
>  	/*
>  	 * A kernel message may contain several lines of output, separated
>  	 * by '\n'.  If the timestamp and decode outputs are forced then each
> @@ -1207,6 +1299,8 @@ static int init_kmsg(struct dmesg_control *ctl)
>  		return -1;
>  	}
>  
> +	ctl->caller_id_size = max_threads_id_size();
> +
>  	return 0;
>  }
>  
> @@ -1262,7 +1356,10 @@ static int parse_kmsg_record(struct dmesg_control *ctl,
>  		goto mesg;
>  
>  	/* D) optional fields (ignore) */
> -	p = skip_item(p, end, ";");
> +	p = skip_item(p, end, ",;");
> +
> +	/* Include optional PRINTK_CALLER field if it is present */
> +	p = parse_callerid(p, end, rec);
>  
>  mesg:
>  	/* E) message text */
> @@ -1390,6 +1487,7 @@ int main(int argc, char *argv[])
>  		.kmsg = -1,
>  		.time_fmt = DMESG_TIMEFTM_TIME,
>  		.indent = 0,
> +		.caller_id_size = 0,
>  	};
>  	int colormode = UL_COLORMODE_UNDEF;
>  	enum {
> -- 
> 2.43.0
> 
> 
