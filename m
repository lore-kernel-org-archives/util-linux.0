Return-Path: util-linux-owner@vger.kernel.org
Received: from mx0.ossmail.de ([79.143.186.47]:49741 "EHLO mx0.ossmail.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751078AbdFAOwa (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 1 Jun 2017 10:52:30 -0400
From: Sebastian Schrader <sebastian.schrader@ossmail.de>
To: util-linux@vger.kernel.org
Cc: sebastian.schrader@ossmail.de
Subject: Re: [PATCH] setpriv: Add --init-groups option
Date: Thu,  1 Jun 2017 16:52:09 +0200
Message-Id: <20170601145210.9588-1-sebastian.schrader@ossmail.de>
In-Reply-To: <m3mv9sernm.fsf@gmail.com>
References: <m3mv9sernm.fsf@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

>> @@ -662,7 +686,11 @@ int main(int argc, char **argv)
>>  			if (opts.have_ruid)
>>  				errx(EXIT_FAILURE, _("duplicate ruid"));
>>  			opts.have_ruid = 1;
>> -			opts.ruid = get_user(optarg, _("failed to parse ruid"));
>> +			pw = get_passwd(optarg, &opts.ruid, _("failed to parse ruid"));
>> +			if (pw) {
>> +				memcpy(&opts.passwd, pw, sizeof(opts.passwd));
>
> This looks somewhat fragile. E.g. with
>    setpriv --ruid foo --euid bar ...
> second call to getpw{nam,id} can overwrite/free memory pointed by opts.passwd.pw_name

You're right, a deep copy should be performed. I've fixed this.

