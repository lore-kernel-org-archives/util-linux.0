Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6E8134BD
	for <util-linux@vger.kernel.org>; Tue,  5 Mar 2024 20:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709671273; cv=none; b=VOLe5C3Vff5+CRUHkC64D2iRjYMQmli3O50bvzV8tNAKdCp6Ai4504SZM8P0cSWPb1SGNEGgOcH+YNxioYxgbJrV2cTdRwbTUdIA2z3ukDfrBhMBJ8tllvaF22BFvhkfUn61IEupDaASb4TzqHZSedjcw2hFsPkWhdUY8dAKyPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709671273; c=relaxed/simple;
	bh=/VjoJyz7k7oXVGDNj9+6N+7V2Mq53sEvT38VPXS+zrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmeaytPXkiCuPHRlU2TWhOo6RWOt7sH1Z5hTTpKPhUtIhEusDZHQe7rKic1Q7bxhC8OXlhP9ZHRumpoARfrV9aQExTN3SHfwnJ0h+Rumlg5WUbry7XlwjJ/m+yPWZL9v5AWl5ONH+ncYYafKLYixmJcClbfJTAKl74jR0p56cvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IUuaQbEC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUuaQbEC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709671270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SwfmyMzeF5yuvnX1WKO6Yck1Kh5ga5PJbO+QbYZZYk0=;
	b=IUuaQbEC6LHslrFK56A8jvSGYy5VORtkGaPxYfkerKsN+DoSKxhcNga4jh3dEuKMcqB6/H
	67wMzkkohPAIVDKd6ueqykjjtw8oknlyFmk9XJ7hMuuaOXjexl2ySB6k5wZUtLCUie4nBv
	4r4qVzTg+shotbPSIdYbd8PikSOZ42s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-VK8eDl24OL6opG78ndboSQ-1; Tue, 05 Mar 2024 15:41:07 -0500
X-MC-Unique: VK8eDl24OL6opG78ndboSQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4EB1D101A526;
	Tue,  5 Mar 2024 20:41:06 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.183])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BBB2112131D;
	Tue,  5 Mar 2024 20:41:04 +0000 (UTC)
Date: Tue, 5 Mar 2024 21:41:02 +0100
From: Karel Zak <kzak@redhat.com>
To: =?utf-8?Q?P=C3=A1draig?= Brady <P@draigBrady.com>
Cc: Paul Eggert <eggert@cs.ucla.edu>,
	Dominique Martinet <asmadeus@codewreck.org>, 69532@debbugs.gnu.org,
	Petr Malat <oss@malat.biz>, Rob Landley <rob@landley.net>,
	util-linux <util-linux@vger.kernel.org>
Subject: Re: bug#69532: mv's new -x option should be made orthogonal to
 -t/-T/default
Message-ID: <20240305204102.vf5yisn2d2wy4svt@ws.net.home>
References: <10c814a7-cb68-4fb4-ad8d-f88f286fb0b1@cs.ucla.edu>
 <58281f96-f9c6-4567-e3c9-c6a6cfa6ce27@draigBrady.com>
 <ZeZqzB4-OzHYfFeQ@codewreck.org>
 <5914e8b2-48ac-456b-9753-6a7bae7a9bbb@cs.ucla.edu>
 <636f1247-0de0-2f32-cb04-f6952b6807aa@draigBrady.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <636f1247-0de0-2f32-cb04-f6952b6807aa@draigBrady.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Tue, Mar 05, 2024 at 02:16:05PM +0000, Pádraig Brady wrote:

> I think having the functionality in mv(1) is better than in rename(1),
> but since exch(1) is already released that's probably
> the best place for this functionality now.
> 
> A separate exch command may be overkill for just this,

rename(1) was also my initial idea, but it's too complex and rarely used
by users for simple tasks like those we can now achieve with the new simple
command exch(1).

> but perhaps related functionality might be added to that command in future.
> For e.g. some of the discussed functionality for a "replace" command
> might reside there.
> 
> So I think I'll remove the as yet unreleased mv --swap from coreutils, given that
> util-linux is as widely available as coreutils on GNU/Linux platforms.

Yes, it seems better to have this Linux-specific feature in
util-linux. We should discuss such changes early next time ;-) 

Thanks for CC:

Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

