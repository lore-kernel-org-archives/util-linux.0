Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404801F959
	for <util-linux@vger.kernel.org>; Tue, 23 Apr 2024 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713882936; cv=none; b=haM0LiGbgayv4IpldM43MnC5q/rEX9PHepDzwzCW6cYRWU/xxdhePNUFxz+Cot337HdiXMuOFili9FuHeq1QzZn7COny1IpccwLZlBkJQ0nhXID3T2KJ9ui8FExATW4gRqhahZs9L3k5EgMwSVLxbP/kQgKslk/atCouVfph2YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713882936; c=relaxed/simple;
	bh=nkEhfhLPXJdmtlXFyidoYD2W1l8LhCZDrGPtBvUOfuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cHNZKy5T7vfYqsrjFUzt+2p4dQd1gTe++977RUeKJ0q+Wi88A46DVXNxX04/PNsNV1lkftUyI9tzOsgEZD/hXnEnUKzEuQjxnaUI//YqPqnAOW5FvzR44MMn3ISQMPUpgasDykb9aHKKjZXGyV8rXwVHiVky9YoGP/klgkhzS10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=JFDhy6ra; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="JFDhy6ra"
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 43NEZJa6007258
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 23 Apr 2024 16:35:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1713882921; bh=dj5aXvydqHvM8csJ7yRsUQaM6l9pD4fqfoYx+86jVjw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JFDhy6raRzeM8Vqj6GKmM05809a2gvouTd5vszqflmlw9YMDwyIgKBcaB1uceyoLZ
	 I0SZY3j8Iyc3HNCpG6/c9me0WliShBTpVPaHKYQD2UnUKkVQOVawzDW+jzxzRaLg7e
	 9ozZrDff6LkYw1cARarcX3fLUrw/JrkvSRUHKgTQ=
Message-ID: <1350349b-8465-4ce6-8dc9-55a32b84dc39@ans.pl>
Date: Tue, 23 Apr 2024 07:35:18 -0700
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: umount -r broken due to "mountinfo unnecessary"
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <315f1f43-013f-48c9-9016-474dc9d53a04@ans.pl>
 <20240423083358.2k532xl557meewws@ws.net.home>
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
Content-Language: en-US
In-Reply-To: <20240423083358.2k532xl557meewws@ws.net.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23.04.2024 at 01:33, Karel Zak wrote:
> On Thu, Apr 18, 2024 at 01:00:56AM -0700, Krzysztof Olędzki wrote:
>> I noticed that "umount -r" does not work on my system for filesystems other than root:
> 
> Fixed: https://github.com/util-linux/util-linux/pull/2989

Perfect, thanks!

When is the next release planned? Also, do you expect a backport to stable/v2.39 and v2.39.5?

Thanks,
 Krzysztof 

