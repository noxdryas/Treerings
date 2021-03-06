%tr_availmap3 stereographic map of northern hemisphere
% The purpose of this script is to see how the realistic Signal-to-noise ratio is globally distributed. % One may think that we have pretty good SNR in general, however, in reality SNR is ~0.25 globally.
% addpath(genpath('/Users/jianghaw/Paleo/CFR_work/matlib/'));
% addpath('/Users/jianghaw/Paleo/CFR_work/data/')
% b = load('pproxy_mann08_sparse_realisticSNR.mat');
% ptype = b.ptype; np = size(ptype,2);
% proxy = b.pproxy{2}(:,:,1);
% pcode = zeros(1,np);
% lon = b.plon; lat = b.plat; % coordinates of the real proxies
% time = b.ptime; nt = length(time);
% 
load JEG_graphics

%preallocate for nproxy
nproxy1 = nan(1,length(group(1).nproxy));
nproxy2 = nan(1,length(group(2).nproxy));
nproxy3 = nan(1,length(group(3).nproxy));
nproxy = vertcat(nproxy1, nproxy2, nproxy3);
%nproxy = vertcat(nproxy1,nproxy2,nproxy3);

tm = zeros(3,group(1).ny);
hl = zeros(3,1); 

proxycolor = zeros(3,3);

icon{1,1}= [1 0 0];   icon{1,2}= '^';
icon{1,3} = sprintf('Raw Data, n = %u', ng1); 
icon{1,4} = 'Raw Data';
icon{2,1}= [.95 .95 0];   icon{2,2}= 'v';
icon{2,3} = sprintf('Quality Controlled Data, n = %u', ng2);
icon{2,4} = 'Quality Controlled Data';
icon{3,1}= [0 .4 0];   icon{3,2}= '*';
icon{3,3} = sprintf('Screened Data, n = %u', ng3);
icon{3,4} = 'Screened Data';



fig('Northern Hemisphere Tree-Ring MXD Availability'),clf
subplot(2.5,1,1:2)
m_proj('stereographic','lat',90,'long',-60,'radius',25);
m_grid('xtick',12,'tickdir','out','ytick',[70 80],'linest','-');
m_coast('patch',[.8 .8 .8],'edgecolor','r');

for j = 1:3
    np = length(group(j).nproxy);
    for i = 1:np
        nproxy(j,i) = group(j).nproxy(i);
    end
    group(j).lon(group(j).lon<0) = group(j).lon(group(j).lon<0) + 360;
    tm(j,:) = group(1).tm;
end

for j = 1:3
    proxycolor(j,:) = icon{j,1};
    hl(j)=m_line(group(j).lon,group(j).lat,'color',icon{j,1},'marker',icon{j,2},'MarkerFaceColor',icon{j,1},'MarkerSize',8.5,'LineStyle','none');
end



[LEGH,OBJH]=legend(hl(:),icon{:,3});%pause; 
set(LEGH,'FontName','Times','FontSize',16,'Location','SouthEast');
set( findobj(OBJH,'Type','line'), 'Markersize', 12)
legend('boxon')

caxis([group(1).year_i , group(1).year_f]), 
colormap(proxycolor), caxis([group(1).year_i,  group(1).year_f]);
h = colorbar2('horiz','Most ancient age resolved');
set(h,'position',[0.13 0.27 0.775 0.04075])
title('NH Tree-Ring MXD Availability','FontWeight','bold','FontSize',14,'FontName','Times');



% export_fig('Proxy_by_age.pdf','-cmyk','-r300')

subplot(3,1,3)


hb = bar(tm(1,:),nproxy','grouped');
axis([300 2000 0 1200])
fancyplot_deco('Temporal Tree-Ring MXD availability','Time','# proxies');

[LEGH,OBJH,OUTH,OUTM]=legend(hb,icon{:,4},'Location','NorthWest'); % 4 is for Lower right-hand corner
set(LEGH,'FontName','Times','FontSize',14);
legend boxoff
% colormap(proxycolor)
orient landscape

pause;legend('boxoff');

print -painters -dpdf -r600 tr_availmap3.pdf