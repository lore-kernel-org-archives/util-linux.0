Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAF912B17E
	for <util-linux@vger.kernel.org>; Tue,  5 Mar 2024 22:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709676808; cv=none; b=mj28i90BAoYA3Heel218oN2rgbaTKfTpTQm+FpS+bUt5MmuooIP2zu9Q8JYd79Hm/bKUDvDDZNknI7FD62LcJc+fCerPGkBpoxIGPkr44M5vL87belOT3xt/RvCjyom86KuPLuCdDJhRxQVTOwbXpjRR0ufdwq1SXYAXZDxQmh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709676808; c=relaxed/simple;
	bh=YW2snb793lLfA3z3O3rjCxLEad6HVwJ5tAONTdsIHw0=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NATjwyFq7d2pZ7CoazxvWpmv9wLwn9I5qhZ9PSuqAtnOZdy0o9DFL9weIDCuOb93bB294h/TGjN94l4pzOAx0+tIAozWDT4k4qakBheFh8AlGP/fzr/drYEdrQqF39vDhmELOtHPCtbntB0HWsr+HtlULxHNll9xcbfoRVKVFpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NOEJlo2T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NOEJlo2T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709676806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w0x4YdCE1RJva5yEwIIKfgCSyAIPoVovArn3e13DwKI=;
	b=NOEJlo2TVEM1NNq2xy5UsnGnHwnH+Id2i3JOwDbj1jph+D7FPoiwyVqKcB+4uBIBYzOXLF
	BMD7pYrLyxL8mjhnDRNopEewX9HYzL0+dPkSBtR1kbimGl0xRTX6osyQNwVDSYRQYFf/uA
	BhZk70G616H4+2JnqHB4br+cv1pn7ik=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-3g0F9G2VMgC9V-VdssyWGw-1; Tue, 05 Mar 2024 17:13:24 -0500
X-MC-Unique: 3g0F9G2VMgC9V-VdssyWGw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08D4881A261;
	Tue,  5 Mar 2024 22:13:24 +0000 (UTC)
Received: from localhost (unknown [10.64.240.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 61D8A40C6CB5;
	Tue,  5 Mar 2024 22:13:22 +0000 (UTC)
Date: Wed, 06 Mar 2024 07:13:21 +0900 (JST)
Message-Id: <20240306.071321.901317834415227362.yamato@redhat.com>
To: P@draigBrady.com
Cc: eggert@cs.ucla.edu, asmadeus@codewreck.org, 69532@debbugs.gnu.org,
 oss@malat.biz, rob@landley.net, util-linux@vger.kernel.org
Subject: Re: bug#69532: mv's new -x option should be made orthogonal to
 -t/-T/default
From: Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <636f1247-0de0-2f32-cb04-f6952b6807aa@draigBrady.com>
References: <ZeZqzB4-OzHYfFeQ@codewreck.org>
	<5914e8b2-48ac-456b-9753-6a7bae7a9bbb@cs.ucla.edu>
	<636f1247-0de0-2f32-cb04-f6952b6807aa@draigBrady.com>
Organization: Red Hat Japan, K.K.
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

When I knew RENAME_EXCHANGE, I thought we should extend mv command as
you did: adding --swap.  However, after researching the past
challenges, I decided not to propose the feature to coreutils.

    https://www.gnu.org/software/coreutils/rejected_requests.html
    https://lists.gnu.org/archive/html/coreutils/2018-12/msg00004.html
    https://www.mail-archive.com/coreutils@gnu.org/msg10276.html

Masatake YAMATO

> On 05/03/2024 04:10, Paul Eggert wrote:
>> On 3/4/24 16:43, Dominique Martinet wrote:
>>> Adding Rob to the loop because this impacts compatibility with
>>> toybox/maybe busybox implementations
>> Busybox does not use RENAME_EXCHANGE, so this isn't a Busybox issue.=

>> Toybox mv added -x to its development version yesterday:
>> https://github.com/landley/toybox/commit/a2419ad52d489bf1a84a9f3aa73=
afb351642c765
>> so there's little prior art there, and there's still plenty of time =
to
>> fix its problems before exposing it to the world.
>> =

>>> I also see --swap mostly used by scripts and this actually feels a =
bit
>>> dangerous to me -- I'd *always* use this with -T.
>> Yes, it's a problem.
>> By "see --swap mostly used by scripts" I assume you mean scripts tha=
t
>> haven't been written yet, assuming that nobody had -x until
>> yesterday....
>> =

>>> (by the way, what's this "rename" command you speak of?
>> https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/
>> Now that I've looked into it further, util-linux already has an "exc=
h"
>> command that does exactly what you want. This is the command that
>> toybox
>> should implement rather than try to simulate it with "mv -x" (which
>> causes all sorts of problems).
>> That is, toybox should revert yesterday's change to "mv", and should=

>> implement "exch" instead.
> =

> I think having the functionality in mv(1) is better than in rename(1)=
,
> but since exch(1) is already released that's probably
> the best place for this functionality now.
> =

> A separate exch command may be overkill for just this,
> but perhaps related functionality might be added to that command in
> future.
> For e.g. some of the discussed functionality for a "replace" command
> might reside there.
> =

> So I think I'll remove the as yet unreleased mv --swap from coreutils=
,
> given that
> util-linux is as widely available as coreutils on GNU/Linux platforms=
.=

> =

> cheers,
> P=E1draig
> =

> =

