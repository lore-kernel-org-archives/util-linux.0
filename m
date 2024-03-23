Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EAAE559
	for <util-linux@vger.kernel.org>; Sat, 23 Mar 2024 10:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711189483; cv=none; b=H5Ebtf1NHJy8cbtycRsRmtV1B9//A375Wq0P6reVJWYY0dC5FnSWuHuHKDobpVJRwBk90RDnPW6wGulvsjtyt1/HkauIEZawUSnsd7o9VxWi3JTnHA4OxFSU3gSZMnJKMYj38ILMPm1I4MciD4YtHe9/T0zqyU1YeeUT531P0Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711189483; c=relaxed/simple;
	bh=sKIQ7I6MjdP9NB8ImdLhiS68+0GJUL2QjAz1J9+HMZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GfhsH0qYDMAvYZ8tqUOZhJubunKKc542Z5uitCefsGPuFp0iTksQURUWhPNTGYlYk2oPWhyRx3uJiorgBvrN5jznOTI7Ga6KJyvXAvOA82o/ySWxl7i0aQiOXjYBJYQaB6Bb2HrQFrW9SbnE2e/kwSrlS2TN/txWfe8YxtG+rz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bernhard-voelker.de; spf=pass smtp.mailfrom=bernhard-voelker.de; dkim=pass (2048-bit key) header.d=bernhard-voelker.de header.i=mail@bernhard-voelker.de header.b=jHkToFog; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bernhard-voelker.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bernhard-voelker.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bernhard-voelker.de header.i=mail@bernhard-voelker.de header.b="jHkToFog"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bernhard-voelker.de; s=s1-ionos; t=1711189459; x=1711794259;
	i=mail@bernhard-voelker.de;
	bh=sKIQ7I6MjdP9NB8ImdLhiS68+0GJUL2QjAz1J9+HMZw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=jHkToFogHqy8ft2C/7eEhNxnjvzOmch0xS3jme8O0h7OEBUsMNAw6sK4ypNx6hiK
	 IUUz7eJ1wYq433/jXnxjj2d54fCll0N/2NRM9tJ/6XArCSOdE/bJ9XwKFJ3LJxGak
	 e/zHClZV16fEiebppxQ97JRytwFBfiU+1RjM4Rqaaf5LJSq7fO8zYNkJ+an6ND6lJ
	 NX8UmvArJAcvRLuRO7zpWQluEIo8iAy9XGgSaYrfNdA982ZRKNKwkMoIPrgiSZYtF
	 pZ4Zefv/2yK8WUbP+UAVqbq+WglKYLHhQMCSzKGDU2K/4YcsKXbLwvF+xpF3IwSRJ
	 TUfZfthRCyIczvXGAw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.101.10] ([91.49.76.118]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mbzhv-1rB3Mb4BAN-00dVty; Sat, 23 Mar 2024 11:24:19 +0100
Message-ID: <9bbddfd0-d4a6-40f8-8ec3-bdbdecbc16ba@bernhard-voelker.de>
Date: Sat, 23 Mar 2024 11:24:18 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bug#69532: mv's new -x option should be made orthogonal to
 -t/-T/default
Content-Language: en-US
To: Karel Zak <kzak@redhat.com>
Cc: Paul Eggert <eggert@cs.ucla.edu>, =?UTF-8?Q?P=C3=A1draig_Brady?=
 <P@draigBrady.com>, 69532@debbugs.gnu.org,
 util-linux <util-linux@vger.kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>, Petr Malat <oss@malat.biz>,
 Rob Landley <rob@landley.net>
References: <10c814a7-cb68-4fb4-ad8d-f88f286fb0b1@cs.ucla.edu>
 <58281f96-f9c6-4567-e3c9-c6a6cfa6ce27@draigBrady.com>
 <ZeZqzB4-OzHYfFeQ@codewreck.org>
 <5914e8b2-48ac-456b-9753-6a7bae7a9bbb@cs.ucla.edu>
 <636f1247-0de0-2f32-cb04-f6952b6807aa@draigBrady.com>
 <c5622a1c-b59e-4eb3-9d81-111acc1fbddc@cs.ucla.edu>
 <11c9a6a2-c73d-4b99-b071-48e7eab2fd19@bernhard-voelker.de>
 <4356f3eb-544e-4ce9-b9ea-374cd01663d5@cs.ucla.edu>
 <dcf073d9-a60b-429d-b9e2-40f6069e2641@bernhard-voelker.de>
 <20240322102257.ovv5kpnm4zsgtf7n@ws.net.home>
From: Bernhard Voelker <mail@bernhard-voelker.de>
In-Reply-To: <20240322102257.ovv5kpnm4zsgtf7n@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:9ojPAkfYOlqMShsx5QHz4FVAsgcZNxS7rAp/CVoVkhklX+DH9NH
 dSsVzV830WAZpBRaQnp7mmlGZqzKPrXC/jWoya7aVhXwSNvLxSKF4FRBHoskgGWmXjLK0A2
 d2pEMZ9v4o0TSR2f0pvx+6XtJ2FXuUbA0EOH0L7muBv4JhwzpUkxQGMiioGGzoBdeVnHMCB
 7REA4aA+rY3zPeTGSUkdw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Vroxbhkr5uE=;U9YZQfy282qbsRDXmadjwmLK61d
 uFO88r2HibCscww1+khN1DaEXLyEKGa1/ZMAGimCQk0jR1n8RzC8NQR8f1Gc5FegJhC8QAW5k
 ZAfBQwUlO2gnpiSYATk/YOtlfWNgxJRZDd5qY80ltwkBtfvivPh0Dm32J/LA13opoZ2FL2NCo
 kE9yLp2e7dCWNsvXLCT6cnva0czPVNvN7W5zAdCPtHfBCxCInKNrKkxBdBYy8onG9oGShpdCU
 ddnQ1SG1rZS2rmwfvduARQHvi7xPmviQMAgaULRuMcAiG/HiwlqfqUUqGzigdtmD4990ChoDe
 PGu+dEzn/6ZO73McB/KtVwo+V034qQ+zVaAOMm1CgiVrGM4Hr17w95VZ2yWetwfKgKj9/ZC7t
 Ffxr7QoVbHRMSkCjkWHeMKuAkA9yWXvl9rUikxB1n+0C2Cuu3ZW3cUlgwtHahCPqhVkcsWz7x
 F47DcSlAJp3pZO/s13nF6iKWqi3t2ZKoNP3T0+TNH0kal6+N4RIvs77Zh5xCX1Cf0Vs5u4kW4
 2BmxVPd5Wz35Zr5hYFJrZtZviga9JDugwiNZ6Xn3Covutcuw3bWU5732Sj5tsHn9jjvshl5Vv
 +quQ0GpLjPWItiu+R8aO3ZRIzBVQ5HbkmIrOKIZSpwEAca/rfRZ4L3vRYSUe1zLQGDI+zOKm5
 QcJID+fob/3lPJJcMI3A/sjj6a1JFr6i0pIRcJBzZdn9hcZpGeTOTKYQBJqFc7fcJcR/bbbxG
 ICHkIc+U/MGGDt4xk7LEFKVMu2oV1uN/0vI3nQQd30s4Ea/T6iEBU4=

On 3/22/24 11:22, Karel Zak wrote:
 > On Wed, Mar 20, 2024 at 11:53:05PM +0100, Bernhard Voelker wrote:>> On userland OTOH, we have broader choice.
 >> Karel did his choice in util-linux for exch(1), and coreutils could expose
 >> the same functionality.
 >>
 >> For other feature requests, we were much more reluctant in coreutils ... for
 >> good reasons: feature bloat, maintainability, etc.
 >>
 >> So I'm asking myself what is different this time?
 >> - The feature already exists -> util-linux.
 >
 > Note that we can move exch(1) from util-linux to coreutils if, at the
 > end of the brainstorming session, the conclusion will be that mv(1) is
 > a bad choice :-)

I'd be for that as well, because ...

 >> I'm currently only 20:80 for adding it to mv(1).
 >
 > I think the functionality will be lost in the mv(1) for many users.

... that's a fair point.

The code for the functionality is in copy.c, so - as with mv.c/cp.c/install.c -
we could have a exch.c using just that part, and thus expose a clearer interface
to the users.

Have a nice day,
Berny
