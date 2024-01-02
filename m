Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B4CEAD9
	for <util-linux@vger.kernel.org>; Tue,  2 Jan 2024 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G7LHyKhD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704196699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+5h1h9TClHMlm7EzSFnBB4Ab/6BEJDMYP9LNx85bobw=;
	b=G7LHyKhDuJvRwn9JWwffBGp/xKm+gYCjvdNt4M8RGhc5HrAYJRWyhig9Tf2I4QkGGcM98d
	6+x5JGmyFIOaYeES+Tlg6lbSzc10Cmh0wDBZ4FVOHzcUghUx/0ezdY+9Urbnk4Yn4VuJxS
	lhjaDCbsOMklCicm6kl2cwhegbH+wek=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-TEi2-m8UPKGbvZVChtjhvQ-1; Tue, 02 Jan 2024 06:58:18 -0500
X-MC-Unique: TEi2-m8UPKGbvZVChtjhvQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3873101A58E;
	Tue,  2 Jan 2024 11:58:17 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.74])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 07BAD3C25;
	Tue,  2 Jan 2024 11:58:16 +0000 (UTC)
Date: Tue, 2 Jan 2024 12:58:15 +0100
From: Karel Zak <kzak@redhat.com>
To: Edward Chron <echron@arista.com>
Cc: util-linux@vger.kernel.org, colona@arista.com, echron@gmail.com
Subject: Re: [PATCH] util-linux-demsg-issue-2666-patch-1.patch
Message-ID: <20240102115815.av7ges3f47m6bciq@ws.net.home>
References: <20231231183336.18934-1-echron@arista.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231231183336.18934-1-echron@arista.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Sun, Dec 31, 2023 at 10:33:36AM -0800, Edward Chron wrote:
> +	if (*rec->caller_id) {
> +		if (ctl->json) {
> +			ul_jsonwrt_value_s(&ctl->jfmt, "caller", rec->caller_id);
> +		} else {
> +			char cidbuf[PID_CHARS_MAX+3] = {'\0'};
> +
> +			sprintf(cidbuf, "[%*s] ",
> +				(char)ctl->caller_id_size, rec->caller_id);
> +			ctl->indent += strnlen(cidbuf, sizeof(cidbuf));
> +			fputs(cidbuf, stdout);
> +		}
> +	}

The variable width (ctl->caller_id_size) of caller ID makes your
regression test fragile, see:

https://github.com/util-linux/util-linux/actions/runs/7384780996/job/20088287790?pr=2647

--- /home/runner/work/util-linux/util-linux/tests/expected/dmesg/cid-limit	2024-01-02 10:34:02.893193174 +0000
+++ /home/runner/work/util-linux/util-linux/tests/output/dmesg/cid-limit	2024-01-02 10:38:29.209015303 +0000
@@ -1,4 +1,4 @@
-[    1.000000] [    T1] example[1]
-[    8.000000] [    T2] example[2]
-[   27.000000] [    T3] example[3]
-[   64.000000] [    T4] example[4]
+[    1.000000] [   T1] example[1]
+[    8.000000] [   T2] example[2]
+[   27.000000] [   T3] example[3]
+[   64.000000] [   T4] example[4]


I see two possible ways to fix it:

 * "normalize" the output in the tests -- just use sed(1) to
   remove all the blanks space "[    T4]" to "[T4]", so the output
   will be always the same

 * or use fixed width for the caller_id in dmesg.c


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

