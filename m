Return-Path: lkml@tlinx.org
Message-ID: <52B1FFED.7010800@tlinx.org>
Date: Wed, 18 Dec 2013 12:05:01 -0800
From: Linda Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: regression bug: user loses DISPLAY & REMOTEHOST with  'su -p - username"
References: <52B0DA78.8060109@tlinx.org> <20131218105454.GA21748@x2.net.home>
In-Reply-To: <20131218105454.GA21748@x2.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> it means that --login and --preserve-environment has been always
> mutually exclusive and the latest version prints wanning when the
> options are use together. It's also described in the man page.
>   
----
    You are right.  Compared back with to core utils 8.9 -- same.
Confused it with an open suse change to call pam_env /session instead of
per_auth which has a similar effect of losing remote DISPLAY/REMOTEHOST
vals.

>   
>> The preserve environment flag is NOT incompatible with login.
>> It means don't clear the env, but do call login via -<shell>.
>>
>> -p means don't clear the ENV -- but do call the user's shell
>> with a '-' in front of it.  That has always been the functionality
>> of 'su'.
>>
>> If you want to make 'su' fancier, maybe it needs a "/etc/suers.conf"
>> file so specific values can be easily changed to reflect
>> site policy rather than hard coding them.
>>     
>
> It would be probably better to use PAM for such things.
>   
----

    PAM doesn't maintain state.  After the initial authorization that 
grants you access to the machine -- the "where" you came from is lost.

    Perhaps this is a deficiency in PAM, can't say, but DISPLAY is
like TERM.  It tells you how to send output to the user.  DISPLAY can be
derived from REMOTEHOST only on initial authorization when the host is
first entered.  Since future "sessions" from a remote-entry all stem from
the initial login, it would seem useful to preserve information about
the origination.  TERM is preserved because it describes the nature of
the terminal functions to use at 'DISPLAY'.  It seems a bit myopic to
save TERM but not DISPLAY. 

    Other vars could easily fall into that category.  But certainly,
losing DISPLAY information is at least, no less valuable than losing TERM.
