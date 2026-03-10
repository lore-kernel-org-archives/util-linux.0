Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F10392C32
	for <util-linux@vger.kernel.org>; Tue, 10 Mar 2026 18:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773168599; cv=none; b=cHuKBOerc+C2/bEWGNn4yKIBmu80WozWhlI5N9XjtUhWwPViiudtC7dYdykmDzquaUy0X2Cxmy95/g5Jc2cxUf33wx7jUym5mpD1kYAQitOH6OYBvXxGcTeXbet3kTNaNOJBJq+i8uLH2VCncxlfaCXQ12Arw8UR8ANOz3xDwSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773168599; c=relaxed/simple;
	bh=KqLGdT7Gi9/vmnpYok9PfYXiX904zWhvCqeXx8QkE90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtVJvt/4IRXBwM3fy3f5N88PWh6FjHYg73+MzkFt5OYdQAGSrwTF5UgzTpDZJbprjm/Gbmx0sWgTKA4iFoFC2d+QC1hrKHev3vtKs6RRaSDwy2GW/ZTMZxd/Hw8VrLd3izHXT8f6zrNpEPpZqCEUh7a+RMSiTJAgGpqobz9A9SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DaBnf8q6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DaBnf8q6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773168593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EN5eaVJ4OgdTZ0twusV4r0zGOYrme4m2h2NsuErnldc=;
	b=DaBnf8q6rULkAID47zvDqlucBirR9jCzvy+o2YgQPG08dXVIifS3jp+xbccRCHzUA2Whfa
	CvWdfVc9VqvdgX5uR5EOv8PB8nSlBlvkWBQ7s+Km95NmkW2Rt6OjUibyl19F9DlCweRl5j
	d1JKR90b4ljuA5xAbtgj2oMpZJOONH0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-Ns3WoYrdPhmPxJf4P0-AIg-1; Tue,
 10 Mar 2026 14:49:51 -0400
X-MC-Unique: Ns3WoYrdPhmPxJf4P0-AIg-1
X-Mimecast-MFC-AGG-ID: Ns3WoYrdPhmPxJf4P0-AIg_1773168590
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 01CBA1956088;
	Tue, 10 Mar 2026 18:49:50 +0000 (UTC)
Received: from ws (unknown [10.45.226.170])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D79381956095;
	Tue, 10 Mar 2026 18:49:48 +0000 (UTC)
Date: Tue, 10 Mar 2026 19:49:45 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org, 
	Mario =?utf-8?Q?Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Subject: Re: improvements to terminal-colors.d.5.adoc were undone
Message-ID: <iio2qnw62rtr5hih47h7m4hyc7glzubqnqonv7n7wjmx2gyljr@lpihqow5qu6n>
References: <cm7cun3pymf6quqcupreoegjj6ycwv3rvbap6ezpvfidvtt4lf@rq74bm7girgz>
 <713c6323-e80e-47fc-9389-520b963a3129@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <713c6323-e80e-47fc-9389-520b963a3129@telfort.nl>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Mar 09, 2026 at 05:08:19PM +0100, Benno Schulenberg wrote:
> 
> Op 09-03-2026 om 11:51 schreef Karel Zak:
> > >   lib/terminal-colors.d.5.adoc | 24 ++++++++++--------------
> > >   1 file changed, 10 insertions(+), 14 deletions(-)
> > 
> > Both patches have been applied. Thank you, and sorry for the delay.
> 
> The second patch was applied in commit 3252142521, but three commits
> later, merge commit d708fc7db6 undoes all the improvements I made.  :/

My mistake, sorry I'll fix it.

> Also, that merge commit says that it just removes the backticks from a
> table, but it actually changes back two simple lists to large, bulky
> tables.

The tables are a better solution than the list for translators. See
discussion:
https://github.com/util-linux/util-linux/pull/4089

The list produces things like (po-man/util-linux-man.pot):

#. type: delimited block _
#: ../lib/terminal-colors.d.5.adoc:115
msgid ""                
"`` *\\a* Bell (ASCII 7)`` `` *\\b* Backspace (ASCII 8)`` `` *\\e* Escape "
"(ASCII 27)`` `` *\\f* Form feed (ASCII 12)`` `` *\\n* Newline (ASCII 10)`` "
"`` *\\r* Carriage Return (ASCII 13)`` `` *\\t* Tab (ASCII 9)`` `` *\\v* "
"Vertical Tab (ASCII 11)`` `` *\\?*{nbsp}{nbsp}{nbsp}Delete (ASCII 127)`` `` "
"*\\_* Space`` `` *\\\\* Backslash (\\)`` `` *\\^* Caret (^)`` `` *\\\\#* "
"Hash mark (#)``"       
msgstr ""             


The table is more readable:

#. type: Table
#: ../lib/terminal-colors.d.5.adoc:131
#, no-wrap
msgid ""
"|0\n"
"|to restore default color\n"
"\n"
"|1\n"
"|for brighter colors\n"
"\n"
"|4\n"
"|for underlined text\n"
"\n"
"|5\n"
"|for flashing text\n"
"\n"
"|30\n"
"|for black foreground\n"
"\n"
"|31\n"
"|for red foreground\n"
"\n"
"|32\n"
"|for green foreground\n"
"\n"
"|33\n"
"|for yellow (or brown) foreground\n"
"\n"
"|34\n"
"|for blue foreground\n"
"\n"
"|35\n"
"|for purple foreground\n"
"\n"
"|36\n"
"|for cyan foreground\n"
"\n"
"|37\n"
"|for white (or gray) foreground\n"
"\n"
"|40\n"
"|for black background\n"
"\n"
"|41\n"
"|for red background\n"
"\n"
"|42\n"
"|for green background\n"
"\n"
"|43\n"
"|for yellow (or brown) background\n"
"\n"
"|44\n"
"|for blue background\n"
"\n"
"|45\n"
"|for purple background\n"
"\n"
"|46\n"
"|for cyan background\n"
"\n"
"|47\n"
"|for white (or gray) background\n"
msgstr ""

> A year ago, commit b3c3d865eb reduced the bulky tables back to simple
> lists.  Can we please keep these simple lists?

The list seems unfriendly to translators in some cases.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

