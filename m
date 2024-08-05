Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6D710953
	for <util-linux@vger.kernel.org>; Mon,  5 Aug 2024 09:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722851354; cv=none; b=oG6f7z6pvqYLF0f0ULHMfP/JLr2qIU6c+PsbDjDUCAPI3W1bUGNowyG/DSobe2l5qGkqt2vSU0YYsEZFRJixxqu+uXVeFZgS0tvoWJ5cplHZit0lhKNau99v0Uwm5uO6wNp867cI4tdVz2jdbkr2ZYhk09oZ4tEQo1nmSmaPXb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722851354; c=relaxed/simple;
	bh=3rc24q+32d1Jteo9Pk9itC0r9VgPhz7VCt/zWhllSak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUfBrO6kxMU+Mwv+JWejuYQNbgB4CckefQgaH9gSRzisleVD5ikC1HGX/M0vmNCz0uxfF1WxsPo0f2vgCnN5VyM63veXOm8elqF9FGv178oQjihSsUcJShiVnK9l+eF/1+4oslZ0dWW0P9tEz3ne6nBERk4SM72zNdZ6yPiRLfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bdGimfaK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bdGimfaK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722851351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v6ZJ6s5P/wJwSdlkQiYaTZuoDUCocqjKbibMEgDXPyU=;
	b=bdGimfaKdPpRear5dt3HAX4Ha7S1iH87PEEs6ghAI0xi7uiAIFIRoaTxyLdYcZGIgUJUXf
	W8FJ5F2syYph1PQppqdxL7+Ef4L+BFrb+LZwEeMRGwXTxgoyQXAwZNjgaYyD6U8Lh8PBB9
	aNuwBEc/Ltoy1kxSll3yJGV3WJkbch8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-X_7VKtVgPOKWvdh7m5zDaQ-1; Mon,
 05 Aug 2024 05:49:09 -0400
X-MC-Unique: X_7VKtVgPOKWvdh7m5zDaQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 076D11955D50;
	Mon,  5 Aug 2024 09:49:08 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.177])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45B89300019F;
	Mon,  5 Aug 2024 09:49:06 +0000 (UTC)
Date: Mon, 5 Aug 2024 11:49:03 +0200
From: Karel Zak <kzak@redhat.com>
To: John Rinehart <johnrichardrinehart@gmail.com>
Cc: util-linux@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: fuse mount failure when type contains '.'
Message-ID: <bytzy2l3mhrcxpcmhqqmyxj7jeu6jafbyu7pmkx3ocupii5tue@qeiobojgjess>
References: <CAGc5Yo9G2mJkbgVAbZESVvBVCK9OF7MWbEf=Mt0tY2XBFg+=yQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGc5Yo9G2mJkbgVAbZESVvBVCK9OF7MWbEf=Mt0tY2XBFg+=yQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


 Hi John,

On Thu, Aug 01, 2024 at 11:16:30AM GMT, John Rinehart wrote:
> `util-linux` seems to fail to handle a use case that users like me seem to
> be hitting with some frequency. The issue is around
> https://github.com/util-linux/util-linux/blob/86b6684e7a215a0608bd130371bd7b3faae67aca/libmount/src/context.c#L2115-L2121
> and seems rooted in the fact that `util-linux` operates on `type` where
> type is always of the form <a>.<b> but where <b> is apparently assumed to
> not contain Unicode U+002E (ASCII 2E): '.' ("dotless"). I say it "appears
> to assume" this since the logic which appears to remove the subtype does so
> by using `strrchr`, which addresses only the last period in the `helper`
> string. If the `subtype`, itself, has a U+002E character then this won't
> remove the subtype.
> 
> As an example, if `helper` looks like
> `path/name.type./subtype/path/with/a.period` then the modified `helper`
> after `strrchr` will look like `path/name.type./subtype/path/with/a`
> instead of the apparently-intended `path/name.type`.

the convention for filesystem names is (was):

    <type>[.<subtype>]

For example, for the "mount" helper, it is:

    /path/mount.<type>[.<subtype>]

I believe it is acceptable for the "path" to contain dots (or any
other characters). The important thing is the last segment of the path
(e.g. /mount.<type>[.<subtype>]). We should not be concerned with
anything else besides the last segment.

It is strange to assume that <subtype> can also contain path-like
segments and dots. It seems like someone may want to use <subtype> to
encode additional information ...

Miklos (CC:), what is your opinion? Is it correct to assume that <subtype>
is whatever?

    Karel


> This crops up for users like me because  I use NixOS which is a store-based
> Linux operating system using paths like:
> ```
> $ readlink -f $(which s3fs)
> 
> /nix/store/xwbx0fbg65ml2qjl86p9p2w58kghqn8r-s3fs-fuse-1.94/bin/s3fs
> ```
> (So, paths like `/nix/store/<hash>-<name>-<version>/bin/<cmd>`). `version`
> is usually a dot-delimited string like `1.23`.
> 
> I've generated a patch which seems to ameliorate this behavior. It's
> attached (sorry if attachments are not the way to go with this mailing
> list, specifically, or mailing lists, generally - this is my first time
> submitting a patch to a mailing list). The logic is simple, but it
> basically iterates through all possible substrings according to the number
> of U+002E characters in the `type` string. It's a more generic form of the
> logic already present, but it's a little heavy-handed. Happy with any and
> all changes which preserve the apparently-corrected behavior.
> 
> Please let me know if I should make any changes or if a change like this
> won't be accepted for some reason or if I'm misunderstanding the
> problem/solution.
> 
> Thank you!
> 
> Cf.
> 1. https://discourse.nixos.org/t/how-to-setup-s3fs-mount/6283/5
> 2. https://github.com/NixOS/nixpkgs/issues/46529#issuecomment-655536831
> 
> -- John Rinehart



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

