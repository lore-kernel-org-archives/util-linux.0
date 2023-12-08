Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VMV4jVx4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56901723
	for <util-linux@vger.kernel.org>; Fri,  8 Dec 2023 03:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702035736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=330gmxBcQjCgg8Rq8tXgFQvJbI9lgYjUPBmGc3UjXgg=;
	b=VMV4jVx4TERgULb0yKjAgGPemH/oQHdmLq2eF2RE7Gs1mhvtDJVrCBBNGNrEb+E6z+DZt4
	htOuikuhzol/MbQWHkAeIBV2dmsnpUwDbyazJsnjjCLpylJLBzWDtJ3Yq8E0ga1YEL0mEE
	GfpKOz62vXtCaX0S1UNCid3COGX29mQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-fo_viI39OMmAUTdLYgh4GA-1; Fri, 08 Dec 2023 06:42:13 -0500
X-MC-Unique: fo_viI39OMmAUTdLYgh4GA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C25185CE41;
	Fri,  8 Dec 2023 11:42:13 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.175])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B3151C185A0;
	Fri,  8 Dec 2023 11:42:12 +0000 (UTC)
Date: Fri, 8 Dec 2023 12:42:10 +0100
From: Karel Zak <kzak@redhat.com>
To: Edward Chron <echron@arista.com>
Cc: util-linux@vger.kernel.org, colona@arista.com
Subject: Re: [PATCH] util-linux/sys-utils dmesg add PRINTK_CALLER id support
Message-ID: <20231208114210.h2rmm7g44tjhjhco@ws.net.home>
References: <20231206210449.27011-1-echron@arista.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206210449.27011-1-echron@arista.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Wed, Dec 06, 2023 at 01:04:49PM -0800, Edward Chron wrote:
>  sys-utils/dmesg.c | 108 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 107 insertions(+), 1 deletion(-)

Note for list-only followers; Edward will create a PR on GitHub
https://github.com/util-linux/util-linux/issues/2609

> +static const char PROC_SYS_KERN_PID_MAX[] = "/proc/sys/kernel/pid_max";

Please, add it as _PATH_PROC_PIDMAX macro to /include/pathnames.h

> +#define PID_CHARS_MAX 16

It's usually better to keep it based on some type, we usually use
something like:

    #define PID_CHARS_MAX sizeof(stringify_value(LONG_MAX))

> +static size_t max_threads_id_size(void)
> +{
> +	char taskmax[PID_CHARS_MAX];

char taskmax[PID_CHARS_MAX] = { '\0' };

> +	ssize_t rdsize;
> +	int fd;
> +
> +	fd = open(PROC_SYS_KERN_PID_MAX, O_RDONLY);
> +	if (fd == -1)
> +		return (size_t)5;
> +
> +	memset(taskmax, 0, sizeof(taskmax));

... and don't use memset() to initialize.

> +	rdsize = read(fd, taskmax, sizeof(taskmax));
> +	if (rdsize == -1)
> +		return (size_t)5;

Maybe we can avoid hardcoded numbers in code

    #define PID_CHARS_DEFAULT   sizeof(stringify_value(SHORT_MAX))

> +static const char *parse_callerid(const char *p_str, const char *end,
> +				  struct dmesg_record *p_drec)
> +{
> +	static const char cid[] = "caller=";

Use macro, compiler will save the string to the right place.

 #define DMESG_CALLER_PREFIX    "caller="
 #define DMESG_CALLER_PREFIXSZ  (sizeof(DMESG_CALLER_PREFIX) - 1)

> +	const char *p_after;
> +	const char *p_next;
> +	size_t cid_size;
> +	char *p_cid;
> +
> +	p_cid = strstr(p_str, cid);
> +	if (p_cid != NULL && p_drec != NULL) {
> +		p_next = p_cid + sizeof(cid)-1;
> +		p_after = skip_item(p_next, end, ",;");
> +		cid_size = p_after - p_next - 1;

 You should verify that cid_size < sizeof(p_drec->caller_id) before you
 call strncpy().

> +		memset(p_drec->caller_id, 0, sizeof(p_drec->caller_id));
> +		strncpy(p_drec->caller_id, p_next, cid_size);

 Please,  xstrncpy() (from include/strdutils.h) to be sure it's zero terminated.

> +		return p_after;
> +	}
> +	return p_str;
> +}
> +
>  /*
>   * Parses one record from syslog(2) buffer
>   */
> @@ -1079,6 +1156,29 @@ full_output:
>  			color_disable();
>  	}
>  
> +	if (rec->caller_id[0] != 0) {
 
 if (*rec->caller_id)

> +		size_t cid_len = strnlen(rec->caller_id, PID_CHARS_MAX);

Would be better to assume that the string zero is terminated? I guess
it's more robust for future code modifications.

> +		ssize_t numspaces;
> +		char strbuf[PID_CHARS_MAX];
> +
> +		numspaces = ctl->caller_id_size - cid_len;
> +
> +		memset(strbuf, 0, sizeof(strbuf));
> +		if (numspaces > 0)
> +			memset(strbuf, ' ', numspaces);
> +
> +		if (ctl->json) {
> +			ul_jsonwrt_value_s(&ctl->jfmt, "caller", rec->caller_id);

Here you assume it's zero terminated.

> +		} else {
> +			char cidbuf[PID_CHARS_MAX];
> +
> +			memset(cidbuf, 0, sizeof(cidbuf));

Again, initialize, don't use memset().

> +			sprintf(cidbuf, "[%s%s] ", strbuf, rec->caller_id);

Do we really need strbuf to create space before the string? What about

    sprintf(cidbuf, "[%*s] ", numspaces, rec->caller_id);


Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

