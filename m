Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FE2274659
	for <util-linux@vger.kernel.org>; Mon, 15 Sep 2025 09:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757928154; cv=none; b=aYq9VXVBjvcfvqHWV5nsxGkBFa8re9tCL103sT59N/hV6lAWH6iYbULAQe0m+vAoHwmbA2XOGXGyAQO6/kOdcxJQT+CnoaTMTXDi8OMwPClciVjoq+AQmM/BYjnPGzRScyRQ6RRXASaZ19Qj/wxcFWY7ihTOJ3lZPRB2faTlNy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757928154; c=relaxed/simple;
	bh=R/iB3UzRwyz/T4r4LuYM1/2tdCuxXh4vOyaNId4UP2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOFC10YdpVKO0+uJvttpb0I6dP5/5UIUyT1cKcYdWYWKAf0d27GW8MNPtqJaC+dLdhQOz3YTYSREcsh4JvJ3SlGtL31WqWn9jeckWdJ47ZrPUyBSsu+Jp1SMUG7e70T8M76W6QXhRYZYleZ0q8OfdQvM8B49JKaAa3anqTExPqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qm0Mu71W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qm0Mu71W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757928147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+Um99/TX5O+wyigXoD1OqCqlmXb7uPuZ06kz+OwJzI=;
	b=Qm0Mu71W+YThk1v6+II0gzQr6fHfKbOlXmrkcKVXv9I7F8oO9B78Ie3PMTDE32hT0jM21S
	XO5bJVqzjeX2FygaT3Vsbsw8zGqOZgwhoNbMgLTOB10ShHCQ7axHS3U5nuuvofOV9ukG2X
	JNqwt7TY7SjWLxGGyaD1btF9OSPu6qo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-ZRDqq6jxM-2x-xgo_BPLeQ-1; Mon,
 15 Sep 2025 05:22:24 -0400
X-MC-Unique: ZRDqq6jxM-2x-xgo_BPLeQ-1
X-Mimecast-MFC-AGG-ID: ZRDqq6jxM-2x-xgo_BPLeQ_1757928143
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C0BAA180048E;
	Mon, 15 Sep 2025 09:22:22 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.252])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D209F1800452;
	Mon, 15 Sep 2025 09:22:21 +0000 (UTC)
Date: Mon, 15 Sep 2025 11:22:18 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] findmnt: (usage) add a needed equals sign before an
 optional argument
Message-ID: <cspldmiiosndipcki3zybaik2edrf2lstkpxxj27rum5xrlfdc@6a4t452pkz7l>
References: <20250911134807.12903-1-bensberg@telfort.nl>
 <47103376-a043-4f78-8213-ba06f52f5116@telfort.nl>
 <rs4jch6hxbont2e56cnshc37hzefhprhlljy2v56xhhtjkfdbm@kgf6bctiicox>
 <14fbf910-bc2b-4bd4-89ce-dac8a4d8c970@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14fbf910-bc2b-4bd4-89ce-dac8a4d8c970@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Sep 12, 2025 at 04:47:57PM +0200, Benno Schulenberg wrote:
> 
> Op 12-09-2025 om 15:18 schreef Karel Zak:
> > On Thu, Sep 11, 2025 at 03:51:48PM +0200, Benno Schulenberg wrote:
> > > 
> > > Op 11-09-2025 om 15:48 schreef Benno Schulenberg:
> > > > -	fputs(_(" -k                     alias to '--kernel mountinfo'\n"), out);
> > > > -	fputs(_(" --kernel[=<method>]    search in kernel mount table (default)\n"
> > > > +	fputs(_(" -k                     an alias for '--kernel=mountinfo'\n"), out);
> > > > +	fputs(_(" --kernel[=<method>]    search in kernel mount table (default behavior);\n"
> > > 
> > > Karel, do you want to roll an rc2, or shall I just make these changes in
> > > rc1 POT file for the TP?
> > 
> > I think RC1 is sufficient for translations for stable releases; we
> > don’t need as long a stabilization period as for major releases.
> > That’s why I asked for an update on TP.
> > 
> > Or do you think including stable release updates on TP is overkill?
> 
> No -- offering stable dot releases for translation is fine,
> as long as the string changes are the same as made in master.

Changes in the stable branches will always be a subset of changes in
the master branch.

The stable branch is almost always about backports (see "cherry-picked
from" in the commit messages of 'git log stable/v2.41'), whereas in
the master branch we often make more invasive changes.

Also note that before a new master release I always sync po/ and
po-man/ against the latest translations from TP. This means the
initial versions of the po/ and po-man/ strings in the major release
2.42 will be from 2.41.2 (or so).

> What I'm asking is: will you apply the patch (both to master
> and to the stable branch)?  If yes, then I'll edit the rc1 POT
> file to correspond with those changes.  (I don't want to offer
> a faulty string and then see it corrected in the next POT.)

When translators are working on strings, it's best to keep them frozen
and do string fixes in the next release (or next -rc). So I have
applied the patch to the master branch only for now. OK?

For a major release (e.g., v2.42), it would be best to do string
translations twice before the final release to allow time to fix
strings and finalize the translations. Maybe for the final release
it would be best to have

-rc1 ... stabilization only, no translations
-rc2 ... translations, string fixes from translators
-rc3 ... final translations

But I'm not sure translators are ready for such repetitive work
(although the second update will probably be quite small).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

