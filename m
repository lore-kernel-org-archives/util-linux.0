Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I8ErPTZ+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84B6125
	for <util-linux@vger.kernel.org>; Mon, 27 Nov 2023 01:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701076193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hORjAaVoUBfHKDIj2KXEhCGQFTuKPfdIzqz/s2/rxH8=;
	b=I8ErPTZ+HZ9Xz3AzirFbJy1Sb9QvjOmkyg0bZG4G1+VktHG5XHXKFLemQopYUh3A2jOj31
	2d1ApNRCTo06vt9gJAH/HGHG2I3mR5zfvq/VHEycvjr8O2gA7ANhXkuzCjtv8Wcv6qt3Nn
	OuCk8MOdyMqXqTw9BuMsQLImXznCP2E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-REo1muOyO8KZiovfdYNgrA-1; Mon, 27 Nov 2023 04:09:48 -0500
X-MC-Unique: REo1muOyO8KZiovfdYNgrA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03D1B101A54C;
	Mon, 27 Nov 2023 09:09:48 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.94])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4912C1C060B0;
	Mon, 27 Nov 2023 09:09:47 +0000 (UTC)
Date: Mon, 27 Nov 2023 10:09:45 +0100
From: Karel Zak <kzak@redhat.com>
To: junxiao.bi@oracle.com
Cc: util-linux@vger.kernel.org, thomas@t-8ch.de, dsimic@manjaro.org
Subject: Re: [PATCH V2] loopdev: report lost loop device file error
Message-ID: <20231127090945.xjqvrtk7l2hlaf5w@ws.net.home>
References: <20231025203603.48584-1-junxiao.bi@oracle.com>
 <20231101115540.eqz6q3prnqhi43y5@ws.net.home>
 <00af5617-923e-41d8-8b23-60178bb6db7a@oracle.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00af5617-923e-41d8-8b23-60178bb6db7a@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On Wed, Nov 01, 2023 at 12:54:16PM -0700, junxiao.bi@oracle.com wrote:
> On 11/1/23 4:55 AM, Karel Zak wrote:
> 
> > On Wed, Oct 25, 2023 at 01:36:03PM -0700, Junxiao Bi wrote:
> > > If a /dev/loopX is lost because someone might have removed it by mistake,
> > > future losetup operations on that loop device will fail.
> >   Thanks Junxiao,
> > 
> >   I has move aggressive with the changes and there is result:
> >   https://github.com/util-linux/util-linux/pull/2566
> Thanks a lot. The changes looks good to me.
> > 
> >   For me the most important is to report used devices although there is
> >   not /dev loop node.
> > 
> > > +static void loopcxt_scan_lost_device_file(struct loopdev_cxt *lc)
> > > +{
> > > +	static int scanned = 0;
> > > +	dev_t devno;
> > > +
> > > +	/*only scan sysfs once for losetup cmd*/
> > > +	if (!scanned)
> > > +		scanned = 1;
> > > +	else
> > > +		return;
> > > +	devno = sysfs_devname_to_devno(lc->device);
> > > +	if (devno <= 0)
> > > +		return;
> > > +
> > > +	fprintf(stderr, "%s is lost, run \"mknod %s b %d %d\" to recover it.\n",
> > > +			lc->device, lc->device, major(devno), minor(devno));
> > > +}
> >   The lib/loopdev.c code is also used in libmount, so it should not
> >   directly print anything on stderr. It's application business to print
> >   the warning. I have moved it to losetup.c
> 
> Should we patch mount to report that error? 

Yes, but first we need improve how libmount works with errors. Now
there is possible to work with errno only. The code that generates
error messages has no access to the 'struct loopdev_cxt`.

I have added a TODO issue for this:
https://github.com/util-linux/util-linux/issues/2605

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

