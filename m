Received: from omta003.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7701AD403
	for <util-linux@vger.kernel.org>; Wed, 29 Jan 2025 16:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.97.99.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169853; cv=none; b=LP74ymxUsZU1dzdonihIoO25YgSfS/JqfmmfdsMl9O5V3xB2XFTWScUAUTJhCX3jDNOJXG4CkBPeslf2ywCVdy1lP7czZOz9SMbgqvYngwLJ9iD+IU+uUdpTLoq9j9bh+IbdYjV1Dbzf4hJadnM1dF5KWzOlBZBvDfdFukWbsxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169853; c=relaxed/simple;
	bh=vSeXSNoTipu7KQAEdFogcABbV9Sh437cigTd0MapaiI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=V8o/AqS+YjCH5tIIEvFPUsk6Sjc6lSoIJsmEtpq+WHVT5dXtctK94zsjzxl42ncuniGTo+lxy3N+Vhbb+Uu0wC4eosdWSjKJnrdo6FVURaOtvfUCN4dCoP6SghoWduAn+VEYOB3pnPct6fCmSYrbyMtyrG4oo6m2rD13JvO63Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuyoix.net; spf=pass smtp.mailfrom=tuyoix.net; arc=none smtp.client-ip=3.97.99.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuyoix.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuyoix.net
Received: from shw-obgw-4002a.ext.cloudfilter.net ([10.228.9.250])
	by cmsmtp with ESMTPS
	id d3lvtV4hWxv7PdBNUtLI3m; Wed, 29 Jan 2025 16:57:24 +0000
Received: from fanir.tuyoix.net ([68.150.218.192])
	by cmsmtp with ESMTP
	id dBNTtMHHGl5eGdBNTtfawq; Wed, 29 Jan 2025 16:57:24 +0000
X-Authority-Analysis: v=2.4 cv=EO6l0EZC c=1 sm=1 tr=0 ts=679a5df4
 a=LfNn7serMq+1bQZBlMsSfQ==:117 a=LfNn7serMq+1bQZBlMsSfQ==:17
 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=M51BFTxLslgA:10
 a=Y-Hw5tHbaIzHENXJ9F0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Received: from CLUIJ (cluij.tuyoix.net [192.168.144.15])
	(authenticated bits=0)
	by fanir.tuyoix.net (8.18.1/8.18.1) with ESMTPSA id 50TGvL1h010268
	(version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 29 Jan 2025 09:57:21 -0700
Date: Wed, 29 Jan 2025 09:57:09 -0700 (Mountain Standard Time)
From: =?UTF-8?Q?Marc_Aur=C3=A8le_La_France?= <tsi@tuyoix.net>
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Add setsid option to save child process id
In-Reply-To: <ez4oc4bocqcilq36ncfjusirdkmt6jkpfvaakrx5qcslzoqj6f@wxu57ze7zutk>
Message-ID: <alpine.WNT.2.20.2501290953590.4996@CLUIJ>
References: <be555f23-ae5e-f7d1-9b7c-28f4191664e7@tuyoix.net> <ez4oc4bocqcilq36ncfjusirdkmt6jkpfvaakrx5qcslzoqj6f@wxu57ze7zutk>
User-Agent: Alpine 2.20 (WNT 67 2015-01-07)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-CMAE-Envelope: MS4xfAO2sI3oPzoEHpHF8li0sjS85BtTlepy/Xowi45vcQJnePxlJ49fGQzYzCATaV2mmnjbrKmEToTjNR13ElrLmemNnw7Vo52ST84fxX0HGPuCqVgNGlO1
 DqMpDxgjIB9qEVGpto3+319QkYi1iPfhghTAw4Qcvx9ze4S29hoOBUGtyGPZFrI55lfnHmpfc/H9Qzb1EBlZj6ThOwJAefjEyhW7IPlv1WeGaH4Nx4WFcP7b

On Wed, 2025-Jan-29, Karel Zak wrote:
> On Sun, Jan 26, 2025 at 10:40:19AM GMT, Marc Aurèle La France wrote:
>> Add an option to save the child's pid into a file.

>> @@ -105,6 +115,16 @@ int main(int argc, char **argv)
>>  			break;
>>  		default:
>>  			/* parent */
>> +			if (pidpath) {
>> +				pidfile = fopen(pidpath, "w");
>> +				if (pidfile == NULL)
>> +					warn(_("cannot open pidfile %s"),
>> +						pidpath);
>> +				else {
>> +					fprintf(pidfile, "%d\n", pid);
>> +					fclose(pidfile);
>> +				}
>> +			}
>>  			if (!status)
>>  				return EXIT_SUCCESS;
>>  			if (wait(&status) != pid)

> What is the intended use-case for this feature?

To put various utilities (ping, tcpdump, ad nauseam) in the background and
have a simple way of controlling each instance individually.

> I am unsure if this implementation is too simplistic. It seems that
> the file is not deleted after the child process exits. Furthermore,
> what would happen if we call multiple setsid instances with the same
> pidfile? Would it be better to create the pidfile in the child process
> after setsid() and ioctl(), in order to avoid creating the
> pidfile in case of an error?

> For reference, the code in misc-utils/uuidd.c uses a more advanced
> method.

Repeat after me:

KISS.

Marc.
