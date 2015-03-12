Return-Path: sitsofe@gmail.com
MIME-Version: 1.0
In-Reply-To: <20150309201259.GC26473@ws.net.home>
References: <CALjAwxjTo=krFxHht2029Sh-h3maEvGK1Xa0fXUOScsamG_=Eg@mail.gmail.com>
	<20150309115259.GB26473@ws.net.home>
	<CALjAwxhefTrWEcxo+P4X98N5W12y2U5Jycj=1sjHju4WsA8ORA@mail.gmail.com>
	<20150309201259.GC26473@ws.net.home>
Date: Thu, 12 Mar 2015 02:10:44 +0000
Message-ID: <CALjAwxgNkt3jgiHe5R63SFkoQOr-BsZ8QTOs-4xkfw_A4dBt4Q@mail.gmail.com>
Subject: Re: agetty --reload
From: Sitsofe Wheeler <sitsofe@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 9 March 2015 at 20:12, Karel Zak <kzak@redhat.com> wrote:
> On Mon, Mar 09, 2015 at 02:38:23PM +0000, Sitsofe Wheeler wrote:
>>
>> Phew, that was fast! I've found with your patches the first issue is
>> fixed but when waiting at the [press ENTER to login] prompt agetty
>> --reload still has no effect...
>
>  It works for me.
>
>  # grep autologin /etc/systemd/system/getty@.service
>  ExecStart=-/sbin/agetty --autologin kzak --login-pause --noclear %I $TERM
>
>  # echo "Hello world!" >> /etc/issue
>  # agetty --reload
>
>  .. then I see the "Hello..." line before [press ENTER to login].

You're right - I was mistaken and it all works.

Just for the record, the reason I was testing this is because I wanted
agetty to update its display of /etc/issue whenever the networking
changed so IP addresses would be updated. My setup is using networkd
and I have the following systemd units:

/etc/systemd/system/multi-user.target.wants/systemd-networkd-change.path:
[Unit]
Description=Update getty on network changes
DefaultDependencies=no
Requisite=systemd-networkd.service
Before=systemd-networkd.service

[Path]
PathChanged=/run/systemd/netif/state

[Install]
WantedBy=multi-user.target

/etc/systemd/system/systemd-networkd-change.service:
[Unit]
Description=Update getty on network changes
DefaultDependencies=no
Conflicts=shutdown.target

[Service]
Type=oneshot
# sleep is needed if watching the state file because it changes too soon
ExecStartPre=/usr/bin/sleep 0.5s
ExecStart=/usr/local/sbin/agetty --reload

The only snag is that the display goes weird when the console is
blanked and an update happens but that could be a VMware bug.

-- 
Sitsofe | http://sucs.org/~sits/
