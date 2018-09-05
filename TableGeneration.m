%% TableGeneration
% Author: Zhang Pengnian
%% ��ȡ�ļ��еĸ�ʽ����
% /...
%   /������Ŀ¼
%       /����1
%       /����2
%       /...
        
%% ���ĸ�ʽ���� 
% |����|��/��|����|����      |�ļ�·��|
% |����|��   |N3  |2017-01-01|*.jpg   |
% |... |... |... |...       |...     |

%% 
clear;
close all;

FileName = '7.16���·ּ�.xlsx';
imds = imageDatastore('D:\Project Files\7.16���·ּ�','IncludeSubfolders',true,'LabelSource','foldernames');
N = size(imds.Files,1);  %ͼƬ����
DatabaseTable = cell(N+1,5);
DatabaseTable(1,:) = {'����','��/��','����','����','�ļ�·��'};

%% 
for i=1:N 
    fp = char(imds.Files(i));
%     fp = imds.Files(i);
%     fp_str = char(fp);
    size_fp = size(fp,2);
%     fp_split = regexp(fp, '-', 'split');
    %% Name
    for j=1:size_fp-2
        if isChinese(fp(size_fp-j)) && isChinese(fp(size_fp-j-1))
            % ���������ҵ������������ĺ��֣���һ�����ֵ�λ����size_fp-j
            NameEndPosition = size_fp-j;
            k=2;
            while isChinese(fp(size_fp-j-k))    
                k=k+1;
            end
            NameStartPosition = NameEndPosition-k+1;
            break;

        end
        if j==size_fp-2
            disp(i);
            error('��������');
        end
    end

    DatabaseTable(i+1,1) = cellstr(fp(NameStartPosition:NameEndPosition));
    
    %% Left or Right
%     if fp(size_fp-5)=='-' && fp(size_fp-7)=='-' && (fp(size_fp-6)=='��' || fp(size_fp-6)=='��')
%         DatabaseTable(i+1,2) = cellstr(fp(size_fp-6));
%     elseif fp(size_fp-6)=='-' && fp(size_fp-8)=='-' && (fp(size_fp-7)=='��' || fp(size_fp-7)=='��')
%         DatabaseTable(i+1,2) = cellstr(fp(size_fp-7));
%     else
%         disp(i);
%         error('��/�� ����');
%     end
    for j=1:size_fp-2
        if fp(size_fp-j)=='-' && fp(size_fp-j-2)=='-' && fp(size_fp-j-1)=='��'
            % j��j-2��'-'��j-1�������
            DatabaseTable(i+1,2) = cellstr('L');
            break;
        elseif fp(size_fp-j)=='-' && fp(size_fp-j-2)=='-' && fp(size_fp-j-1)=='��'
            DatabaseTable(i+1,2) = cellstr('R');
            break;
        end
        if j==size_fp-2
            disp(i);
            error('���ҳ���');
        end
    end
   
    %% Grade
    for j=1:size_fp-2
        if fp(size_fp-j) == '\'
            DatabaseTable(i+1,3) = cellstr([fp(size_fp-j-2),fp(size_fp-j-1)]);
            break;
        end
        if j==size_fp-2
            disp(i);
            error('�������');
        end
    end
    
    %% Date
    for j=1:size_fp-2
        if fp(size_fp-j) == '\'
            DatabaseTable(i+1,4) = cellstr(fp(size_fp-j+1:size_fp-j+10));
            break;
        end
        if j==size_fp-2
            disp(i);
            error('���ڳ���');
        end
    end
    %%
    DatabaseTable(i+1,5) = cellstr(fp);
    
end

xlswrite(FileName,DatabaseTable);


    
    
    
    
    
    
    
    
    
    