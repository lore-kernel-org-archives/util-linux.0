Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A974A2C86D
	for <util-linux@vger.kernel.org>; Mon, 14 Jul 2025 20:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752526137; cv=none; b=gTJd4wPis0DL0ZUIb89jaJfE+Gs38OY9pf2i2EaoAYW8zrvFDXW9Z/kuA+8TUXOyHyhbrzbB9JcDeXyOCt5c60JmQCGZwynSWTl89dDAQwkeAIlfrqIm+3BVCysTZ5uDT4be4PN5wGdBrXxor7/jIPqzFU68cyqN/R9XwXQHtb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752526137; c=relaxed/simple;
	bh=xeFrcSW5KMBSt1XnHzOg+Q31vHLBOPEnqUkfwi0m0jU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uRlmIS3KKatwGDytYH5A4pTfBOl73GJBurB20wlabckhK4HPtzaRx1oVDqi9EWRamYCN3R2hg7u/b09yOEy7ONdCOAy7SUBgwTw8vP0IpMB07pyvbSW3Zfk5FZAOninekQ4yPEcx+iOOKwJpffS7prfgx8NnV0/mzo0SGTYsM0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B541E1655;
	Mon, 14 Jul 2025 13:48:44 -0700 (PDT)
Received: from [192.168.20.57] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AB333F6A8;
	Mon, 14 Jul 2025 13:48:53 -0700 (PDT)
Message-ID: <fb54d607-dccc-419f-b92c-7bc8514213a6@arm.com>
Date: Mon, 14 Jul 2025 15:48:50 -0500
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] lscpu-arm: Remove the "Ampere-1a" part.
To: Karel Zak <kzak@redhat.com>, Paul Benoit <paul@os.amperecomputing.com>
Cc: util-linux@vger.kernel.org
References: <20250711211648.53361-1-paul@os.amperecomputing.com>
 <20250711211648.53361-2-paul@os.amperecomputing.com>
 <crm5fcuper7bhu7iv7jbejf3rnowwo4tuwrjnutngta56dedgm@zajfg6nh2okx>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <crm5fcuper7bhu7iv7jbejf3rnowwo4tuwrjnutngta56dedgm@zajfg6nh2okx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/25 7:16 AM, Karel Zak wrote:
> On Fri, Jul 11, 2025 at 02:16:48PM -0700, Paul Benoit wrote:
>> Remove the "Ampere-1a" part.  On newer Ampere Computing systems, the
>> system/model name will be obtained from /sys/bus/soc/devices/soc0/machine,
>> that is populated with the ARM SMC CC SOC_ID Name.
> 
> If I understand correctly, there are old systems without
> /sys/.../soc0/machine, right? The change will remove Ampere-1a from
> the lscpu output. This sounds backward incompatible.

Thats a good point, but as I understand it, Ampere hasn't been happy 
with the string that is there.

If its OK to break whatever scripts/etc might depend on it at the 
moment, why not just update the string.

Then invert the check so that the /sys/bus entry is preferred?

