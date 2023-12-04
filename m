Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JOxRwKrv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A518D6C
	for <util-linux@vger.kernel.org>; Mon,  4 Dec 2023 04:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701691354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nlUj5y2sWQo7OnEelAzdu+IUOHOGGClXv9gSbbeUXCc=;
	b=JOxRwKrv2RIRkQPgkXSivuLDZKOS77bWxe1+9k2WVZqjRErO4J2LeafLrml4Kv9tSwWYoY
	V2Z4vYkZQ3l0xwKukFoav68b3bpBsXtMf3yw7roUtOQxrbudlUrePlVQdWmzwIR1WnUvl7
	CDxm2n1nL56An3G13kgPJsgEezoU+PI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-HMbgvnQyOXq6t1DMRWVFug-1; Mon, 04 Dec 2023 07:02:31 -0500
X-MC-Unique: HMbgvnQyOXq6t1DMRWVFug-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C7596185A785;
	Mon,  4 Dec 2023 12:02:30 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.175])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 39AC8492BFC;
	Mon,  4 Dec 2023 12:02:30 +0000 (UTC)
Date: Mon, 4 Dec 2023 13:02:28 +0100
From: Karel Zak <kzak@redhat.com>
To: Rishabh Thukral <rthukral@arista.com>
Cc: util-linux@vger.kernel.org, colona@arista.com
Subject: Re: [PATCH] util-linux/sys-utils dmesg support for additional human
 readable timestamp
Message-ID: <20231204120128.c3iysmc6i47bdkla@ws.net.home>
References: <20231110232612.10969-1-rthukral@arista.com>
 <20231123093045.c5cmdviyupxr2wn7@ws.net.home>
 <CAPfLGEGXhMd5=f59PnA4rBKS6jDFP6=pWmqUhZR4PW5Sioj+=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPfLGEGXhMd5=f59PnA4rBKS6jDFP6=pWmqUhZR4PW5Sioj+=w@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Mon, Nov 27, 2023 at 12:23:38PM -0600, Rishabh Thukral wrote:
> Thanks for reviewing the patch and sharing your feedback. I'll work on the
> changes that are recommended. I also wanted to share the thought behind
> this design approach to stick with a fixed order of timestamp formats.
> Since we are allowing users to specify the `--time-format` option multiple
> times, there is no potential limit to how many times the user might specify
> it. There could be duplicate entries of the same time format appearing
> again and again and we'll have to collect the entire user input requiring

The same problem are --output <columns> we use in many tools. The
solution is hardcoded limit. It's usually 2 times number of the all
possible items. 

> an arbitrarily large input buffer. With a fixed-size buffer, there might be
> a possibility of buffer overflow. One alternative here is to have a complex
> data structure that is fixed in size and keeps track of unique time formats
> in a sequence of appearance in user input. Would it be a good idea to have
> something like this?

I think add

     struct dmesg_control {
     ...
        int     timefmts[2 * __DMESG_NTIMEFMTS];
        size_t  ntimefmts;
     }


would be enough. In the getopt_long() loop you can compare ntimefmts
with ARRAY_SIZE(ctl->timefmts) to check for the hardcoded limit (or
introduce a new function add_timefmt() to hide the detail).

> The existing approach of marking which timestamps were included in user
> input makes it easier to deal with the interactions with other time-format
> options like `-d (--delta)`, `-T (--ctime)`, `-H (--human)`, `-e
> (--reltime)`, `-r (--raw)`, `-t (--notime)`.

Well, option like --ctime is alias to --time-format ctime, so if we
will support multiple --time-format, then

    dmesg --ctime --time-format delta

is the same as 

    dmesg --time-format ctime --time-format delta

It means two add_timefmt() calls in both cases.

And if there is a conflict, then --time-format should be the winner,
or don't support the interaction.

It's fine to define conflict between command line options. See
ul_excl_t excl[], there is already defined that you cannot use --raw
with something else.

> If we maintain a list of all
> user input we might have to insert, delete, or replace some entries based
> on these other specified options and follow a convention in what order
> should new values be inserted.

Sounds too complicated. It's better to be strict and easy to explain :-)

> Let me know your thoughts on this and I can proceed to implement changes
> based on your suggestions.

Keep it simple and stupid ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

