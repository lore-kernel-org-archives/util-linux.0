Received: from omta004.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB6F3B19A
	for <util-linux@vger.kernel.org>; Thu, 30 Jan 2025 18:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.97.99.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738260373; cv=none; b=Qs9OaTmGcT2YyyiUT7qFxKJRqNko0CHi1ipXFGddJSp3VBU8VBvZwWKIRAMgyR4qwvRFdlI1MPyeeZ3/WDMTwZp9KC/Nu+KpDwLTkBl10txg2/1AOl61XVSN8qfHBXh5GbkeD7+Sh3mA02CYDLGa2w8PVfyf107JQAkK31SV41Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738260373; c=relaxed/simple;
	bh=ZsMkPfa4cbpwQoasBH5o6MlelR6Gyg1j+DvQ+PLp5Qc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dFsDmvI632SNVreI8nVXUmfYepNJI3ysN+bNIuCnlgTnTQE3450WzCVkoftftP6Ql/8QgC8NaXNtb0qZlFe6fWCdzvz+tBdCK5bEc7ZbvIiM+RPFoslSH+Oo7jHPiYBaGdsyjr8jgEmsb8zcx3MseSnARsoGCDmN9hPti0cz3lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuyoix.net; spf=pass smtp.mailfrom=tuyoix.net; arc=none smtp.client-ip=3.97.99.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuyoix.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuyoix.net
Received: from shw-obgw-4002a.ext.cloudfilter.net ([10.228.9.250])
	by cmsmtp with ESMTPS
	id dUsptlkmDyLQGdYvTtKblL; Thu, 30 Jan 2025 18:06:03 +0000
Received: from fanir.tuyoix.net ([68.150.218.192])
	by cmsmtp with ESMTP
	id dYvStRvZgl5eGdYvSthoxH; Thu, 30 Jan 2025 18:06:03 +0000
X-Authority-Analysis: v=2.4 cv=EO6l0EZC c=1 sm=1 tr=0 ts=679bbf8b
 a=LfNn7serMq+1bQZBlMsSfQ==:117 a=LfNn7serMq+1bQZBlMsSfQ==:17
 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=M51BFTxLslgA:10
 a=N90rB-LGG_99SKLpv9oA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
Received: from CLUIJ (cluij.tuyoix.net [192.168.144.15])
	(authenticated bits=0)
	by fanir.tuyoix.net (8.18.1/8.18.1) with ESMTPSA id 50UI618V011653
	(version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 30 Jan 2025 11:06:01 -0700
Date: Thu, 30 Jan 2025 11:05:45 -0700 (Mountain Standard Time)
From: =?UTF-8?Q?Marc_Aur=C3=A8le_La_France?= <tsi@tuyoix.net>
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Add setsid option to save child process id
In-Reply-To: <alpine.WNT.2.20.2501290953590.4996@CLUIJ>
Message-ID: <alpine.WNT.2.20.2501301054350.2556@CLUIJ>
References: <be555f23-ae5e-f7d1-9b7c-28f4191664e7@tuyoix.net> <ez4oc4bocqcilq36ncfjusirdkmt6jkpfvaakrx5qcslzoqj6f@wxu57ze7zutk> <alpine.WNT.2.20.2501290953590.4996@CLUIJ>
User-Agent: Alpine 2.20 (WNT 67 2015-01-07)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-CMAE-Envelope: MS4xfAi3Qfi6ATtgqcI/nZD6fcXM7dE6b0GgudFDxWJX6c5Z1WzhMCBWc90FqlYbAn+gVAGQ3/KsS1Tcc3lb1KH+BcUPQe56khFQrBckrUlIR1qapkNobNMd
 /5gWH1JwgcgKKAfBXsefqW4kAXsMM9ukVLZA/ZxO++r0BwyXo9R2AtEclH0U7Apnrg/eTef9yYVB29bg/SzCUWtGzwq8YuU0YHOUTHuOfudxMT0OWHkDGWZO

On Wed, 2025-Jan-29, Marc Aurèle La France wrote:
> On Wed, 2025-Jan-29, Karel Zak wrote:
>> On Sun, Jan 26, 2025 at 10:40:19AM GMT, Marc Aurèle La France wrote:

It would appear some clarification is in order here.

>>> Add an option to save the child's pid into a file.

>>> @@ -105,6 +115,16 @@ int main(int argc, char **argv)
>>>  			break;
>>>  		default:
>>>  			/* parent */
>>> +			if (pidpath) {
>>> +				pidfile = fopen(pidpath, "w");
>>> +				if (pidfile == NULL)
>>> +					warn(_("cannot open pidfile %s"),
>>> +						pidpath);
>>> +				else {
>>> +					fprintf(pidfile, "%d\n", pid);
>>> +					fclose(pidfile);
>>> +				}
>>> +			}
>>>  			if (!status)
>>>  				return EXIT_SUCCESS;
>>>  			if (wait(&status) != pid)

>> What is the intended use-case for this feature?

> To put various utilities (ping, tcpdump, ad nauseam) in the background and
> have a simple way of controlling each instance individually.

>> I am unsure if this implementation is too simplistic.

Yes, that's what the KISS principle is about.

>> It seems that the file is not deleted after the child process exits.

This could be done, but only if --wait is also specified.

>> Furthermore, what would happen if we call multiple setsid instances
>> with the same pidfile?

Like other things in life, you get what you ask for.

>> Would it be better to create the pidfile in the child process after
>> setsid() and ioctl(), in order to avoid creating the pidfile in case of
>> an error?

>> For reference, the code in misc-utils/uuidd.c uses a more advanced
>> method.

This is not intended to be some default pidfile management mechanism.
Indeed, it cannot be.  As my documentation insert clearly states, a pid is
to be saved into a file.  Full stop.

> Repeat after me:

> KISS.

Thus, what I am accusing you of stands.  You are trying to make this far
more complicated than it needs to be.

Marc.
