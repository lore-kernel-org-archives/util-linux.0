Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D85322A4F6
	for <util-linux@vger.kernel.org>; Tue, 21 Oct 2025 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761040837; cv=none; b=IU0LlC1iWcfvBMA5+Ovb3aBkjwGNo5qFFDSJG7lELdKuVGjd/JB9EdbeN2ymnGSEkj5XW+jLE6/MzEuuorAHqf+Oa1HfaB1WAW+fM96DQHHmZZPY1rf0xtFz72fmsjnzOUWDnxzXvvYUlaJl0FMbH50fMqw6db2j9lh1SSERi9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761040837; c=relaxed/simple;
	bh=lFEHHFexxNMTDR4NZ2cciPUX7uhRGONEm0OXLE7sPCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghireitspIhYT9wgUZWVsS9sEc8NLA77Ea/VuimuDbmwGpS/kfFxjqHn1/FCytQvqapRj0g08ZrHlFfsQCnCdrcF+hEBU8jG76aneERH7wB8uFEuhf3ienqU3k5l5Sb2c4ASjNXXeFDSLK011lVDjU7loZSvJh0N+1c3reyDzwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ToaY3jrT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ToaY3jrT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761040835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ke/OF+7qvVwgjHXm7M7WXHobmpzhb+jqi6h5MAQNS5Q=;
	b=ToaY3jrT1f+V4X10xDwagkVudAu+wl7Skjx63J8OhmL42E06zb9vswkUbjbcxd+iruFYCh
	PA4O38J6SEISJzJpGkPAsKcjUDvnY1nHMJ2x/DDUjBvUgPpY4wyUrHTPsfQpEsV1uZ6k6E
	h7iil4VrAJp2d3ZOgWn/KCsbSN0faW8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-Wo7UM5GqP1q2Jt3YKm9Eow-1; Tue,
 21 Oct 2025 06:00:30 -0400
X-MC-Unique: Wo7UM5GqP1q2Jt3YKm9Eow-1
X-Mimecast-MFC-AGG-ID: Wo7UM5GqP1q2Jt3YKm9Eow_1761040829
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F04A1956094;
	Tue, 21 Oct 2025 10:00:28 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.89])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B9661800577;
	Tue, 21 Oct 2025 10:00:26 +0000 (UTC)
Date: Tue, 21 Oct 2025 12:00:23 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: Util-Linux <util-linux@vger.kernel.org>, 
	wguanghao <wuguanghao3@huawei.com>
Subject: Re: `losetup --remove` is confusing, and misuse silently fails
Message-ID: <ymw6pydao6vwwvav346losfnhvynbxapxxoiv77eoendsgnqa4@dcimzsl3szvn>
References: <a5909aac-3f54-4fce-8785-410535dd4098@telfort.nl>
 <wog3s3sk34ewa6ulgspplk6fhb4hwd3nd55wse3gk2dsl6avyl@yqoq3miwfx5n>
 <f875b695-a682-4ab8-bfb5-95dd5d861236@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f875b695-a682-4ab8-bfb5-95dd5d861236@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Oct 17, 2025 at 10:55:17AM +0200, Benno Schulenberg wrote:
> 
> Op 16-10-2025 om 12:28 schreef Karel Zak:
> > https://github.com/util-linux/util-linux/pull/3803
> 
> Misusing the tool now gives a surprising a result:
> 
>   # ./losetup --remove --detach
>   losetup: /dev/--detach: remove failed: Success
> 
>   # ./losetup --remove --detach loop0
>   losetup: /dev/--detach: remove failed: Success
>   losetup: /dev/loop0: remove failed: Device or resource busy

Ah, this is unpleasant. Thank you for reporting it. 

> Ideally, `losetup` would first interpret all options, and complain
> that --remove and --detach cannot be combined.  (The code for that
> seems to be there, but it doesn't appear to have any effect.)
> 
> But at least it shouldn't print "Success" when something failed.

Both issues should be fixed in the branch. I have changed how it uses
--detach, --remove, and --set-capacity to assume the device name
follows the options rather than requiring it as an option's argument.

It returns the mutually exclusive check to the game and avoids
interpreting an option as a device name.

 # ./losetup --remove --detach loop0
 losetup: mutually exclusive arguments: --detach-all --all --set-capacity --detach --find --associated --remove

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

